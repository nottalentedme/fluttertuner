//Модель для данных о строе, которая хранит список нот и частот для каждой струны. Это объект, с которым будут работать репозиторий и другие компоненты.
class GuitarTuningModel {
  final List<String> notes;//используем список нот и символов
  final List<double> frequencies;
  GuitarTuningModel({
    required this.notes,
    required this.frequencies,
  });
}
