// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:typed_data';

import 'package:fluttertuner/feature/tuner/data/models/note_model.dart';
import 'package:fluttertuner/feature/tuner/domain/entity/note_entity.dart';
import 'package:fluttertuner/feature/tuner/domain/repository/interface/tuning_repository.dart';
import 'package:fluttertuner/feature/tuner/service/buffer/buffer_service_interface.dart';
import 'package:fluttertuner/feature/tuner/service/recorder/tuner_audio_interface_service.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'package:pitchupdart/pitch_handler.dart';

class TuningRepositoryImpl implements TuningRepository {
  final AudioRecorderService _audioRecorderService;
  final BufferService _bufferService;
  final PitchDetector _pitchDetector;
  final PitchHandler _pitchHandler;
  late StreamController<WrongNoteEntity> _noteStreamController;
  late StreamSubscription sub;
  @override
  Stream<WrongNoteEntity> get noteStream => _noteStreamController.stream;

  TuningRepositoryImpl(
    this._audioRecorderService,
    this._bufferService,
    this._pitchDetector,
    this._pitchHandler,
  );

  @override
  Future<void> startAudio() async {
    _noteStreamController = StreamController();
    print('stream started');
    final recordStream = await _audioRecorderService.startRecording();
    var audioSampleBufferedStream = _bufferService.toBuffer(recordStream);
    sub = audioSampleBufferedStream.listen((audioSample) async {
      final intBuffer = Uint8List.fromList(audioSample);

      final detectedPitch =
          await _pitchDetector.getPitchFromIntBuffer(intBuffer);
      if (detectedPitch.pitched) {
        final currentFreq = detectedPitch.pitch;
        final pitchResult = await _pitchHandler.handlePitch(currentFreq);
        _noteStreamController.sink.add(
          WrongNoteModel.fromPitchResult(pitchResult),
        );
      }
    });
  }

  @override
  Future<void> stopAudio() async {
    _noteStreamController.close();
    await sub.cancel();
    await _audioRecorderService.stopRecording();
  }
}
