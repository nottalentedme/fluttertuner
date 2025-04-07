import 'dart:typed_data';

import 'package:buffered_list_stream/buffered_list_stream.dart';
import 'package:fluttertuner/feature/tuner/service/buffer/buffer_service_interface.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';

class BufferServiceImpl implements BufferService {
  @override
  Stream<List<int>> toBuffer(Stream<Uint8List> recordStream) {
    final bufferedList = bufferedListStream(
      recordStream.map((event) {
        return event.toList();
      }),
      //The library converts a PCM16 to 8bits internally. So we need twice as many bytes
      PitchDetector.DEFAULT_BUFFER_SIZE * 2,
    );
    return bufferedList;
  }
}
