class MetronomeState {
  final bool isRunning;
  final int tempo;

  MetronomeState({required this.isRunning, required this.tempo});

  factory MetronomeState.initial() {
    return MetronomeState(isRunning: false, tempo: 120);
  }

  MetronomeState copyWith({bool? isRunning, int? tempo}) {
    return MetronomeState(
      isRunning: isRunning ?? this.isRunning,
      tempo: tempo ?? this.tempo,
    );
  }
}
