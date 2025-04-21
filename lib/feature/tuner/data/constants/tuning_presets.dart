import 'package:fluttertuner/feature/tuner/data/models/note_model.dart';
import 'package:fluttertuner/feature/tuner/data/models/tuning_model.dart';

class TuningPresets {
  static const standardTuning = TuningModel(
    name: 'Standard E',
    notes: [
      NoteModel(name: 'E2', frequency: 82.41),
      NoteModel(name: 'A2', frequency: 110.00),
      NoteModel(name: 'D3', frequency: 146.83),
      NoteModel(name: 'G3', frequency: 196.00),
      NoteModel(name: 'B3', frequency: 246.94),
      NoteModel(name: 'E4', frequency: 329.63),
    ],
  );

  static const dropDTuning = TuningModel(
    name: 'Drop D',
    notes: [
      NoteModel(name: 'D2', frequency: 73.42),
      NoteModel(name: 'A2', frequency: 110.00),
      NoteModel(name: 'D3', frequency: 146.83),
      NoteModel(name: 'G3', frequency: 196.00),
      NoteModel(name: 'B3', frequency: 246.94),
      NoteModel(name: 'E4', frequency: 329.63),
    ],
  );

  static const defaultTunings = [standardTuning, dropDTuning];
}
