class GuitarTuningModel {
  final List<String> notes; //используем список нот и символов
  final List<double> frequencies;
  GuitarTuningModel({
    required this.notes,
    required this.frequencies,
  });
}

class GuitarTuning {
  final String name;
  final List<String> strings;

  const GuitarTuning({
    required this.name,
    required this.strings,
  });

  // Стандартный строй
  const factory GuitarTuning.standard() = _StandardTuning;
  const factory GuitarTuning.dropD() = _DropDTuning;
  const factory GuitarTuning.dropC() = _DropCTuning;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GuitarTuning &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          strings == other.strings;

  @override
  int get hashCode => name.hashCode ^ strings.hashCode;
}

class _StandardTuning extends GuitarTuning {
  const _StandardTuning()
      : super(
          name: 'Standard E',
          strings: const ['E2', 'A2', 'D3', 'G3', 'B3', 'E4'],
        );
}

class _DropDTuning extends GuitarTuning {
  const _DropDTuning()
      : super(
          name: 'Drop D',
          strings: const ['D2', 'A2', 'D3', 'G3', 'B3', 'E4'],
        );
}

class _DropCTuning extends GuitarTuning {
  const _DropCTuning()
      : super(
          name: 'Drop C',
          strings: const ['C2', 'G2', 'C3', 'F3', 'A3', 'D4'],
        );
}

final Map<String, double> noteFrequencies = {
  'C2': 65.41,
  'C#2': 69.30,
  'D2': 73.42,
  'D#2': 77.78,
  'E2': 82.41,
  'F2': 87.31,
  'F#2': 92.50,
  'G2': 98.00,
  'G#2': 103.83,
  'A2': 110.00,
  'A#2': 116.54,
  'B2': 123.47,
  'C3': 130.81,
  'C#3': 138.59,
  'D3': 146.83,
  'D#3': 155.56,
  'E3': 164.81,
  'F3': 174.61,
  'F#3': 185.00,
  'G3': 196.00,
  'G#3': 207.65,
  'A3': 220.00,
  'A#3': 233.08,
  'B3': 246.94,
  'C4': 261.63,
  'C#4': 277.18,
  'D4': 293.66,
  'D#4': 311.13,
  'E4': 329.63,
  'F4': 349.23,
  'F#4': 369.99,
  'G4': 392.00,
  'A4': 440.00,
  'B4': 493.88,
};

int findClosestStringIndex(GuitarTuning tuning, double freq) {
  double minDiff = double.infinity;
  int closestIndex = 0;

  for (int i = 0; i < tuning.strings.length; i++) {
    final note = tuning.strings[i];
    final noteFreq = noteFrequencies[note];
    if (noteFreq == null) continue;

    final diff = (noteFreq - freq).abs();
    if (diff < minDiff) {
      minDiff = diff;
      closestIndex = i;
    }
  }

  return closestIndex;
}
