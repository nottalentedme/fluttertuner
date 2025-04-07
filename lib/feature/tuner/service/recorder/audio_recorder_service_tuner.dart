import 'dart:typed_data';

import 'package:fluttertuner/feature/tuner/service/recorder/tuner_audio_impl_service.dart';

class AudioRecorderServiceTuner {
  final AudioRecorderServiceImpl _audioRecorderService;

  AudioRecorderServiceTuner()
      : _audioRecorderService = AudioRecorderServiceImpl();
  @override
  Future<Stream<Uint8List>> startRecording() async {
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
