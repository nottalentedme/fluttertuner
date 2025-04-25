import 'dart:typed_data';

import '../../../config/dependency.dart';

abstract class AudioRecorderService extends Service {
  Future<Stream<Uint8List>> startRecording();
  Future<bool> hasPermission();
  Future<void> stopRecording();
  Future<void> cancelRecording();
  Future<void> dispose();
}
