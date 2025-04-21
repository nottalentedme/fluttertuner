// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:fluttertuner/feature/tuner/data/constants/tuning_presets.dart';
import 'package:fluttertuner/feature/tuner/data/models/note_model.dart';
import 'package:fluttertuner/feature/tuner/data/models/tuning_model.dart';
import 'package:fluttertuner/feature/tuner/domain/entity/note_entity.dart';
import 'package:fluttertuner/feature/tuner/service/buffer/buffer_service_interface.dart';
import 'package:fluttertuner/feature/tuner/service/recorder/tuner_audio_interface_service.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'package:pitchupdart/pitch_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class TuningRepository {
  Future<void> startAudio();
  Future<void> stopAudio();
  Stream<WrongNoteEntity> get noteStream;
  Future<void> saveCustomTuning(TuningModel tuning);
  Future<List<TuningModel>> loadCustomTunings();
  Future<void> selectTuning(TuningModel tuning);
  TuningModel get currentTuning;
  Future<void> switchMode(TuningMode mode);
  NoteModel findNearestNote(double frequency);
  TuningMode get currentMode;
}

class TuningRepositoryImpl implements TuningRepository {
  final AudioRecorderService _audioRecorderService;
  final BufferService _bufferService;
  final PitchDetector _pitchDetector;
  final PitchHandler _pitchHandler;

  late StreamController<WrongNoteEntity> _noteStreamController;
  late StreamSubscription sub;
  late TuningModel _currentTuning;

  TuningMode _currentMode = TuningMode.scale;
  static const _prefsKey = 'custom_tunings';

  @override
  Stream<WrongNoteEntity> get noteStream => _noteStreamController.stream;

  TuningRepositoryImpl(
    this._audioRecorderService,
    this._bufferService,
    this._pitchDetector,
    this._pitchHandler,
  );

  @override
  TuningModel get currentTuning => _currentTuning;

  @override
  NoteModel findNearestNote(double frequency) {
    return _currentTuning.notes.cast<NoteModel>().reduce((a, b) =>
        (frequency - a.frequency).abs() < (frequency - b.frequency).abs()
            ? a
            : b);
  }

  double _calculateCentsDifference(double actualFreq, double targetFreq) {
    return 1200 * (log(actualFreq / targetFreq) / ln2);
  }

  @override
  Future<void> startAudio() async {
    _noteStreamController = StreamController.broadcast();
    print('stream started');
    final recordStream = await _audioRecorderService.startRecording();
    var audioSampleBufferedStream = _bufferService.toBuffer(recordStream);

    sub = audioSampleBufferedStream.listen((audioSample) async {
      final intBuffer = Uint8List.fromList(audioSample);
      final detectedPitch =
          await _pitchDetector.getPitchFromIntBuffer(intBuffer);

      print('detected pitched');
      print(detectedPitch.pitch);

      if (detectedPitch.pitched) {
        final currentFreq = detectedPitch.pitch;

        if (_currentTuning.mode == TuningMode.scale) {
          final nearest = findNearestNote(currentFreq);
          final diffCents =
              _calculateCentsDifference(currentFreq, nearest.frequency);

          _noteStreamController.sink.add(
            WrongNoteModel(
              name: nearest.name,
              frequency: nearest.frequency,
              diffCents: diffCents,
            ),
          );
        } else {
          final nearest = findNearestNote(currentFreq);
          final diffCents =
              _calculateCentsDifference(currentFreq, nearest.frequency);

          _noteStreamController.sink.add(
            WrongNoteModel(
              name: nearest.name,
              frequency: nearest.frequency,
              diffCents: diffCents,
            ),
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
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getStringList(_prefsKey) ?? [];
    existing.add(jsonEncode(tuning.toJson()));
    await prefs.setStringList(_prefsKey, existing);
  }

  @override
  Future<List<TuningModel>> loadCustomTunings() async {
    final prefs = await SharedPreferences.getInstance();
    final customTuningsJson = prefs.getStringList(_prefsKey) ?? [];

    final customTunings = customTuningsJson
        .map((json) => TuningModel.fromJson(jsonDecode(json)))
        .toList();

    return [
      ...TuningPresets.defaultTunings, // Стандартные строи
      ...customTunings, // Пользовательские строи
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
