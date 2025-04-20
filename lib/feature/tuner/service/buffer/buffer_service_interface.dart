import 'dart:typed_data';

import '../../../config/dependency.dart';

abstract interface class BufferService extends Service {
  Stream<List<int>> toBuffer(Stream<Uint8List> recordStream);
}
