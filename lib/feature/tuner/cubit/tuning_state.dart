// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fluttertuner/feature/tuner/data/models/instrument_model.dart';
import 'package:fluttertuner/feature/tuner/data/models/note_model.dart';
import 'package:fluttertuner/feature/tuner/data/models/tuning_model.dart';
import 'package:fluttertuner/feature/tuner/domain/entity/note_entity.dart';
import 'package:fluttertuner/feature/tuner/domain/entity/tuning_entity.dart';
import 'package:fluttertuner/feature/tuner/domain/models/guitar_tuning_model.dart';

class TuningState {
  final WrongNoteEntity note; // текущая определённая нота
  final NoteEntity targetNote; // ближайшая нота из выбранного строя
  final TuningEntity tuning; // строй
  final int currentStringIndex; // индекс текущей струны

  const TuningState({
    required this.note,
    required this.tuning,
    required this.targetNote,
    required this.currentStringIndex,
  });

  factory TuningState.initial() {
    return const TuningState(
      note: WrongNoteModel(frequency: 123123, name: 'E', diffCents: 3333),
      tuning: TuningModel(
        description: "description",
        instrument: InstrumentModel(name: '232', strings: 4),
        notes: [],
      ),
      targetNote: NoteModel(frequency: 33333, name: 'C'),
      currentStringIndex: 0,
    );
  }

  TuningState copyWith({
    WrongNoteEntity? note,
    NoteEntity? targetNote,
    TuningEntity? tuning,
    int? currentStringIndex,
  }) {
    return TuningState(
      note: note ?? this.note,
      targetNote: targetNote ?? this.targetNote,
      tuning: tuning ?? this.tuning,
      currentStringIndex: currentStringIndex ?? this.currentStringIndex,
    );
  }
}
