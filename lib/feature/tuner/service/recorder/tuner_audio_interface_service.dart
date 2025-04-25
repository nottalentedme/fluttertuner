import 'dart:typed_data';

import '../../../config/dependency.dart';

abstract class AudioRecorderService extends Service {
  ///
  ///Начинает стрим(поток)
  ///возвращает [Stream<Uint8List>]
  Future<Stream<Uint8List>> startRecording();
  Future<bool> hasPermission();

  ///
  ///Останавливает стрим
  Future<void> stopRecording();

  ///
  ///Прекращает стрим
  Future<void> cancelRecording();
  Future<void> dispose();
}
