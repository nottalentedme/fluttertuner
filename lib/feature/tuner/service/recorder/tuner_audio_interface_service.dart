import 'dart:typed_data';

import '../../../config/dependency.dart';

abstract class AudioRecorderService extends Service {
  Future<Stream<Uint8List>> startRecording();
  Future<void> stopRecording(); //Тут незнаю насчет вопроса
  Future<void> cancelRecording();
  Future<void> dispose();
}
