import 'package:flutter/foundation.dart';
import 'package:fluttertuner/feature/tuner/service/recorder/tuner_audio_interface_service.dart';
import 'package:record/record.dart';

class AudioRecorderService implements TunerAudioRecorderService {
  final AudioRecorder _record = AudioRecorder();

  @override
  Future<void> cancelRecording() async {
    await _record.cancel();
  }

  @override
  Future<void> dispose() async {
    await _record.dispose();
  }

  @override
  Future<bool> hasPermission() async {
    return await _record.hasPermission();
  }

  @override
  Future<void> startRecording() async {
    if (await hasPermission()) {
      try {
        final stream = await _record.startStream(
            const RecordConfig(encoder: AudioEncoder.pcm16bits)); //Либо стрим
        stream.listen(
          (data) {
            print(
              _record.convertBytesToInt16(Uint8List.fromList(data)),
            );
          },
          onError: (error) {
            print('Ошибка аудиостриминга: $error');
          },
          onDone: () {
            print("Все успешно");
          },
        );
      } catch (e) {
        print('Ошибка аудиостриминга: $e');
      }
    } else {
      throw ('Нет разрешения');
    }
  }

  @override
  Future<void> stopRecording() async {
    await _record.stop();
    // ... or cancel it (and implicitly remove file/blob).
    //await _record.cancel();
  }
}
