import 'package:fluttertuner/feature/tuner/domain/models/guitar_tuning_model.dart';

class TuningState {
  final String note; // текущая определённая нота
  final double frequency; // определённая частота
  final double diffFrequency; // разница в Гц (с фактической нотой)
  final int centsDiff; // разница в центах
  final String targetNote; // ближайшая нота из выбранного строя
  final double targetFrequency; // её частота
  final GuitarTuning currentTuning; // строй
  final int currentStringIndex; // индекс текущей струны

  const TuningState({
    required this.note,
    required this.frequency,
    required this.diffFrequency,
    required this.centsDiff,
    required this.targetNote,
    required this.targetFrequency,
    required this.currentTuning,
    required this.currentStringIndex,
  });

  TuningState copyWith({
    String? note,
    double? frequency,
    double? diffFrequency,
    int? centsDiff,
    String? targetNote,
    double? targetFrequency,
    GuitarTuning? currentTuning,
    int? currentStringIndex,
  }) {
    return TuningState(
      note: note ?? this.note,
      frequency: frequency ?? this.frequency,
      diffFrequency: diffFrequency ?? this.diffFrequency,
      centsDiff: centsDiff ?? this.centsDiff,
      targetNote: targetNote ?? this.targetNote,
      targetFrequency: targetFrequency ?? this.targetFrequency,
      currentTuning: currentTuning ?? this.currentTuning,
      currentStringIndex: currentStringIndex ?? this.currentStringIndex,
    );
  }
}
