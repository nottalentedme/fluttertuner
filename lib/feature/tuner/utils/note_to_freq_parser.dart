import 'dart:math';

import 'package:tonic/tonic.dart';

class NoteToFrequencyParser {
  double noteToFrequency(String note) {
    final noteMidi = Pitch.parse(note).midiNumber;
    final noteFrequency = 440 * pow(2, (noteMidi - 69) / 12);
    return noteFrequency.toDouble();
  }
}
