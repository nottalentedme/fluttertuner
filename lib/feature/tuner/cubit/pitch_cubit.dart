import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/feature/tuner/cubit/tuning_state.dart';
import 'package:fluttertuner/feature/tuner/service/buffer/buffer_service_interface.dart';
import 'package:fluttertuner/feature/tuner/service/recorder/tuner_audio_interface_service.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'package:pitchupdart/pitch_handler.dart';
import 'package:pitchupdart/tuning_status.dart';

class PitchCubit extends Cubit<TuningState> {
  final AudioRecorderService _audioRecorderService;
  final PitchDetector _pitchDetector;
  final BufferService _bufferService;
  final PitchHandler _pitchHandler;
  StreamSubscription? _audioStreamSubscription;

  PitchCubit(
    this._audioRecorderService,
    this._pitchDetector,
    this._bufferService,
    this._pitchHandler,
  ) : super(TuningState(
          note: "N/A",
          diffFrequency: 0.0,
        )) {
    print('PitchCubit created');
  }

  @override
  Future<void> close() async {
    print('PitchCubit destroyed');
    await _audioRecorderService.stopRecording();
    await _audioRecorderService.dispose();
    return super.close();
  }

  Future<void> startTuning() async {
    final recordStream = await _audioRecorderService.startRecording();
    var audioSampleBufferedStream = _bufferService.toBuffer(recordStream);

    _audioStreamSubscription = audioSampleBufferedStream.listen((audioSample) {
      final intBuffer = Uint8List.fromList(audioSample);

      _pitchDetector
          .getPitchFromIntBuffer(intBuffer)
          .then((detectedPitch) async {
        if (detectedPitch.pitched) {
          _pitchHandler.handlePitch(detectedPitch.pitch).then((pitchResult) => {
                emit(TuningState(
                  note: pitchResult.note,
                  diffFrequency: detectedPitch.pitch,
                ))
              });
        }
      });
    });
  }

  Future<void> stopStream() async {
    await _audioStreamSubscription?.cancel();
    await _audioRecorderService.cancelRecording();
  }
}

extension Description on TuningStatus {
  String getDescription() => switch (this) {
        TuningStatus.tuned => "Настроено",
        TuningStatus.toolow => "Низко",
        TuningStatus.toohigh => "Высоко",
        TuningStatus.waytoolow => "Слишком низко",
        TuningStatus.waytoohigh => "Слишком высоко",
        TuningStatus.undefined => "Нота не определена",
      };
}
