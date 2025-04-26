import 'package:flutter/foundation.dart';
import 'package:fluttertuner/core/service/permissions/mic_permission_interface.dart';
import 'package:fluttertuner/feature/tuner/service/recorder/tuner_audio_interface_service.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'package:record/record.dart';

class AudioRecorderServiceImpl implements AudioRecorderService {
  final AudioRecorder _record = AudioRecorder();
  final MicPermissionService _permissionService;

  AudioRecorderServiceImpl(this._permissionService);

  @override
  Future<void> cancelRecording() async {
    await _record.cancel();
  }

  @override
  Future<void> dispose() async {
    await _record.dispose();
  }

  @override
  Future<Stream<Uint8List>> startRecording() async {
    await _permissionService.requestPermission();
    final hasMicPermission = await _permissionService.hasPermission();
    if (!hasMicPermission) {
      throw Exception('Нет разрешения');
    }
    try {
      final recordStream = await _record.startStream(const RecordConfig(
        encoder: AudioEncoder.pcm16bits,
        numChannels: 1,
        bitRate: 128000,
        sampleRate: PitchDetector.DEFAULT_SAMPLE_RATE,
      ));
      return recordStream;
    } catch (e) {
      print('Ошибка аудиостриминга: $e');
      throw Exception('Не удалось начать аудиозапись');
    }
  }

  @override
  Future<void> stopRecording() async {
    await _record.stop();
  }
}
