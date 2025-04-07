import 'dart:typed_data';

abstract interface class BufferService {
  Stream<List<int>> toBuffer(Stream<Uint8List> recordStream);
}
