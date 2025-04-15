import '../domain/models/guitar_tuning_model.dart';

class TuningState {
  final String note;
  final double frequency;
  final double diffFrequency;
  final GuitarTuning currentTuning;
  final int currentStringIndex;

  const TuningState({
    required this.note,
    required this.diffFrequency,
    this.frequency = 0.0,
    this.currentTuning = const GuitarTuning.standard(),
    this.currentStringIndex = 0,
  });

  TuningState copyWith({
    String? note,
    double? frequency,
    double? diffFrequency,
    GuitarTuning? currentTuning,
    int? currentStringIndex,
  }) {
    return TuningState(
      note: note ?? this.note,
      frequency: frequency ?? this.frequency,
      diffFrequency: diffFrequency ?? this.diffFrequency,
      currentTuning: currentTuning ?? this.currentTuning,
      currentStringIndex: currentStringIndex ?? this.currentStringIndex,
    );
  }
}