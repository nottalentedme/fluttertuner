import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/feature/tuner/cubit/tuning_state.dart';
import 'package:fluttertuner/feature/tuner/service/buffer/buffer_service_interface.dart';
import 'package:fluttertuner/feature/tuner/service/recorder/tuner_audio_interface_service.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'package:pitchupdart/tuning_status.dart';

class PitchCubit extends Cubit<TuningState> {
  final AudioRecorderService _audioRecorderService;
  final PitchDetector _pitchDetector;
  final BufferService _bufferService;

  PitchCubit(
      this._audioRecorderService, this._pitchDetector, this._bufferService)
      : super(TuningState(note: "N/A", diffFrequency: 0.0)) {
    _init();
    print('PitchCubit created');
  }

  @override
  Future<void> close() async {
    print('PitchCubit destroyed');
    return super.close();
  }

  _init() async {
    final recordStream = await _audioRecorderService.startRecording();

    var audioSampleBufferedStream = _bufferService.toBuffer(recordStream);

    await for (var audioSample in audioSampleBufferedStream) {
      final intBuffer = Uint8List.fromList(audioSample);

      _pitchDetector.getPitchFromIntBuffer(intBuffer).then((detectedPitch) {
        if (detectedPitch.pitched) {} //TODO сравнивать с выбранной струной
        //TODO передавать выбранную струну
      });
    }
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
