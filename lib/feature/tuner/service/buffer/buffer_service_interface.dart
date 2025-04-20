import 'dart:typed_data';

import 'package:fluttertuner/core/di/dependency.dart';

abstract interface class BufferService extends Service {
  Stream<List<int>> toBuffer(Stream<Uint8List> recordStream);
}
