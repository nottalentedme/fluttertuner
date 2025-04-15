import 'dart:typed_data';

abstract class AudioRecorderService {
  Future<Stream<Uint8List>> startRecording();
  Future<bool> hasPermission();
  Future<void> stopRecording(); //Тут незнаю насчет вопроса
  Future<void> cancelRecording();
  Future<void> dispose();
}
