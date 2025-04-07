import 'package:fluttertuner/feature/tuner/domain/models/tuning_model.dart';
import 'package:fluttertuner/feature/tuner/service/compareNote/compare_note_interface.dart';
import 'package:fluttertuner/feature/tuner/utils/note_to_freq_parser.dart';
import 'package:pitch_detector_dart/pitch_detector_result.dart';

class CompareNoteImpl implements CompareNote {
  @override
  double compareWithString(PitchDetectorResult pitch, TuningModel note) {
    final noteFreq = NoteToFrequencyParser().noteToFrequency(note.name);

    final diffFrequency = noteFreq - pitch.pitch;

    return diffFrequency;
  }
}
