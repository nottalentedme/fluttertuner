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
  final bool isStandard;
  final String description;

  const GuitarTuning({
    required this.name,
    required this.strings,
    this.isStandard = false,
    this.description = '',
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
          isStandard: true,
          description: 'Стандартный строй гитары (E A D G B E)',
        );
}

class _DropDTuning extends GuitarTuning {
  const _DropDTuning()
      : super(
          name: 'Drop D',
          strings: const ['D2', 'A2', 'D3', 'G3', 'B3', 'E4'],
          description: 'Строй с пониженной шестой струной (D A D G B E)',
        );
}

class _DropCTuning extends GuitarTuning {
  const _DropCTuning()
      : super(
          name: 'Drop C',
          strings: const ['C2', 'G2', 'C3', 'F3', 'A3', 'D4'],
          description: 'Строй с пониженными на тон струнами (C G C F A D)',
        );
}
