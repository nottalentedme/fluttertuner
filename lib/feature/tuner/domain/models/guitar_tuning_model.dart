import 'package:fluttertuner/feature/tuner/domain/entity/tuning/tuning_entity.dart';

class GuitarTuningModel implements TuningEntity {
  @override
  final List<String> notes; //используем список нот и символов
  @override
  final List<double> frequencies;
  GuitarTuningModel({
    required this.notes,
    required this.frequencies,
  });
}
