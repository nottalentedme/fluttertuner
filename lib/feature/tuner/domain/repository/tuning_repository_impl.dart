// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:fluttertuner/feature/tuner/data/constants/tuning_presets.dart';
import 'package:fluttertuner/feature/tuner/data/models/note_model.dart';
import 'package:fluttertuner/feature/tuner/data/models/tuning_model.dart';
import 'package:fluttertuner/feature/tuner/domain/entity/note_entity.dart';
import 'package:fluttertuner/feature/tuner/domain/repository/interface/tuning_repository.dart';
import 'package:fluttertuner/feature/tuner/service/buffer/buffer_service_interface.dart';
import 'package:fluttertuner/feature/tuner/service/recorder/tuner_audio_interface_service.dart';
import 'package:fluttertuner/feature/tuner/service/tuning_storage/tuning_storage.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'package:pitchupdart/pitch_handler.dart';

class TuningRepositoryImpl implements TuningRepository {
  final AudioRecorderService _audioRecorderService;
  final BufferService _bufferService;
  final PitchDetector _pitchDetector;
  final PitchHandler _pitchHandler;
  final TuningStorage _tuningStorage;

  late StreamController<WrongNoteEntity> _noteStreamController;
  late StreamSubscription sub;
  TuningModel _currentTuning = TuningPresets.standardTuning;

  TuningMode _currentMode = TuningMode.scale;

  @override
  Stream<WrongNoteEntity> get noteStream => _noteStreamController.stream;

  TuningRepositoryImpl(
    this._audioRecorderService,
    this._bufferService,
    this._pitchDetector,
    this._pitchHandler,
    this._tuningStorage,
  );

  @override
  TuningModel get currentTuning => _currentTuning;

  int _currentStringIndex = 0;

  @override
  void setStringIndex(int index) {
    _currentStringIndex = index;
  }

  double _calculateCentsDifference(double actualFreq, double targetFreq) {
    return 1200 * (log(actualFreq / targetFreq) / ln2);
  }

  @override
  Future<void> startAudio() async {
    _noteStreamController = StreamController();
    final recordStream = await _audioRecorderService.startRecording();
    var audioSampleBufferedStream = _bufferService.toBuffer(recordStream);

    sub = audioSampleBufferedStream.listen((audioSample) async {
      final intBuffer = Uint8List.fromList(audioSample);
      final detectedPitch =
          await _pitchDetector.getPitchFromIntBuffer(intBuffer);

      if (detectedPitch.pitched) {
        final currentFreq = detectedPitch.pitch;

        if (_currentMode == TuningMode.scale) {
          final nearest = currentTuning.notes[_currentStringIndex];
          final diffCents =
              _calculateCentsDifference(currentFreq, nearest.frequency);
          print('${nearest.frequency},  ${nearest.name}');
          _noteStreamController.sink.add(
            WrongNoteModel(
              name: nearest.name,
              frequency: nearest.frequency,
              diffCents: diffCents,
            ),
          );
        } else if (_currentMode == TuningMode.chromatic) {
          final pitchResult = await _pitchHandler.handlePitch(currentFreq);

          _noteStreamController.sink.add(
            WrongNoteModel.fromPitchResult(pitchResult),
          );
        }
      }
    });
  }

  @override
  Future<void> stopAudio() async {
    _noteStreamController.close();
    await sub.cancel();
    await _audioRecorderService.stopRecording();
  }

  @override
  Future<void> saveCustomTuning(TuningModel tuning) async {
    _tuningStorage.saveCustomTuning(tuning);
  }

  @override
  Future<List<TuningModel>> loadCustomTunings() async {
    final customTunings = await _tuningStorage.loadCustomTunings();

    return [
      ...TuningPresets.defaultTunings,
      ...customTunings,
    ];
  }

  @override
  Future<void> selectTuning(TuningModel tuning) async {
    _currentTuning = tuning;
  }

  @override
  Future<void> switchMode(TuningMode mode) async {
    _currentMode = mode;
  }

  @override
  TuningMode get currentMode => _currentMode;
}
