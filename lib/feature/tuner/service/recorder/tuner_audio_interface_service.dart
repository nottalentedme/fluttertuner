abstract class TunerAudioRecorderService {
  Future<void> startRecording();
  Future<bool> hasPermission();
  Future<void> stopRecording();//Тут незнаю насчет вопроса
  Future<void> cancelRecording();
  Future<void> dispose();
}
