import 'package:fluttertuner/feature/tuner/service/recorder/tuner_audio_impl_service.dart';
import 'package:fluttertuner/feature/tuner/service/recorder/tuner_audio_interface_service.dart';

class AudioRecorderServiceTuner {
  final TunerAudioRecorderService _audioRecorderService;

  AudioRecorderServiceTuner() : _audioRecorderService = AudioRecorderService();
  @override
  Future<void> startRecording() async {
    return await _audioRecorderService.startRecording();
  }

  @override
  Future<bool> hasPermission() async {
    return await _audioRecorderService.hasPermission();
  }

  @override
  Future<void> stopRecording() async {
    return await _audioRecorderService.stopRecording();
  }

  @override
  Future<void> cancelRecording() async {
    return await _audioRecorderService.cancelRecording();
  }

  @override
  Future<void> dispose() async {
    return await _audioRecorderService.dispose();
  }
}
