import 'package:fluttertuner/feature/tunings/domain/entity/tuning_entity.dart';

class TuningState {
  TuningState({
    required this.tuning,
    required this.availableTunings,
  });

  factory TuningState.initial() {
    return TuningState(
      tuning: null,
      availableTunings: [],
    );
  }

  final TuningEntity? tuning;
  final List<TuningEntity> availableTunings;

  TuningState copyWith({
    TuningEntity? tuning,
    List<TuningEntity>? availableTunings,
  }) {
    return TuningState(
      tuning: tuning ?? this.tuning,
      availableTunings: availableTunings ?? this.availableTunings,
    );
  }
}
