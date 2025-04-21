// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fluttertuner/feature/tuner/data/constants/tuning_presets.dart';
import 'package:fluttertuner/feature/tuner/data/models/instrument_model.dart';
import 'package:fluttertuner/feature/tuner/data/models/note_model.dart';
import 'package:fluttertuner/feature/tuner/data/models/tuning_model.dart';
import 'package:fluttertuner/feature/tuner/domain/entity/note_entity.dart';
import 'package:fluttertuner/feature/tuner/domain/entity/tuning_entity.dart';
import 'package:fluttertuner/feature/tuner/domain/models/guitar_tuning_model.dart';

class TuningState {
  final WrongNoteEntity note; // текущая определённая нота
  final NoteEntity targetNote; // ближайшая нота из выбранного строя
  final TuningModel tuning; // строй
  final int currentStringIndex;
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
      note: WrongNoteModel(frequency: 123123, name: 'E', diffCents: 3333),
      tuning: TuningPresets.standardTuning,
      targetNote: NoteModel(frequency: 33333, name: 'C'),
      currentStringIndex: 0,
      availableTunings: [],
      mode: TuningMode.scale,
    );
  }

  TuningState copyWith({
    WrongNoteEntity? note,
    NoteEntity? targetNote,
    TuningModel? tuning,
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
