import 'package:fluttertuner/feature/tuner/domain/entity/instrument_entity.dart';

class InstrumentModel implements InstrumentEntity {
  const InstrumentModel({
    required this.name,
    required this.strings,
  });

  @override
  final String name;

  @override
  final int strings;
}
