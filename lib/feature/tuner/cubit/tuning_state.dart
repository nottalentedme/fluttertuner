// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fluttertuner/feature/tunings/data/models/note_model.dart';
import 'package:fluttertuner/feature/tunings/data/models/tuning_model.dart';
import 'package:fluttertuner/feature/tunings/domain/entity/note_entity.dart';
import 'package:fluttertuner/feature/tunings/domain/entity/tuning_entity.dart';

class TuningState {
  final WrongNoteEntity note; // текущая определённая нота
  final NoteEntity? targetNote; // ближайшая нота из выбранного строя
  final TuningEntity? tuning; // строй
  final int? currentStringIndex;
  final List<TuningModel> availableTunings;
  final TuningMode mode;

  const TuningState({
    required this.note,
    required this.tuning,
    required this.targetNote,
    required this.currentStringIndex,
    required this.availableTunings,
    required this.mode,
  });

  factory TuningState.initial() {
    return const TuningState(
      tuning: null,
      note: WrongNoteModel(frequency: 0, name: 'Play!', diffCents: 0.0),
      targetNote: null,
      currentStringIndex: null,
      availableTunings: [],
      mode: TuningMode.chromatic,
    );
  }

  TuningState copyWith({
    WrongNoteEntity? note,
    NoteEntity? targetNote,
    TuningEntity? tuning,
    int? currentStringIndex,
    List<TuningModel>? availableTunings,
    TuningMode? mode,
  }) {
    return TuningState(
      note: note ?? this.note,
      targetNote: targetNote ?? this.targetNote,
      tuning: tuning ?? this.tuning,
      currentStringIndex: currentStringIndex ?? this.currentStringIndex,
      availableTunings: availableTunings ?? this.availableTunings,
      mode: mode ?? this.mode,
    );
  }
}
