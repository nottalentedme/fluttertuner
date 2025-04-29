import 'package:fluttertuner/feature/tunings/data/models/note_model.dart';
import 'package:fluttertuner/feature/tunings/data/models/tuning_model.dart';

class TuningPresets {
  // Guitar tunings
  static const standardTuning = TuningModel(
    name: 'Стандарт (Гитара)',
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
    name: 'Drop D (Гитара)',
    notes: [
      NoteModel(name: 'D2', frequency: 73.42),
      NoteModel(name: 'A2', frequency: 110.00),
      NoteModel(name: 'D3', frequency: 146.83),
      NoteModel(name: 'G3', frequency: 196.00),
      NoteModel(name: 'B3', frequency: 246.94),
      NoteModel(name: 'E4', frequency: 329.63),
    ],
  );

  static const standardBass = TuningModel(
    name: 'Стандарт (Бас)',
    notes: [
      NoteModel(name: 'E1', frequency: 41.20),
      NoteModel(name: 'A1', frequency: 55.00),
      NoteModel(name: 'D2', frequency: 73.42),
      NoteModel(name: 'G2', frequency: 98.00),
    ],
  );

  static const standardUkulele = TuningModel(
    name: 'Standard (Укулеле)',
    notes: [
      NoteModel(name: 'G4', frequency: 392.00),
      NoteModel(name: 'C4', frequency: 261.63),
      NoteModel(name: 'E4', frequency: 329.63),
      NoteModel(name: 'A4', frequency: 440.00),
    ],
  );

  static const standardViolin = TuningModel(
    name: 'Стандарт (Скрипка)',
    notes: [
      NoteModel(name: 'G3', frequency: 196.00),
      NoteModel(name: 'D4', frequency: 293.66),
      NoteModel(name: 'A4', frequency: 440.00),
      NoteModel(name: 'E5', frequency: 659.26),
    ],
  );

  static const sevenStringGuitar = TuningModel(
    name: 'Стандарт (7 струн))',
    notes: [
      NoteModel(name: 'B1', frequency: 61.74),
      NoteModel(name: 'E2', frequency: 82.41),
      NoteModel(name: 'A2', frequency: 110.00),
      NoteModel(name: 'D3', frequency: 146.83),
      NoteModel(name: 'G3', frequency: 196.00),
      NoteModel(name: 'B3', frequency: 246.94),
      NoteModel(name: 'E4', frequency: 329.63),
    ],
  );

  static const defaultTunings = [
    standardTuning,
    dropDTuning,
    standardBass,
    standardUkulele,
    standardViolin,
    sevenStringGuitar
  ];
}
