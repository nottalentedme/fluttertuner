// ignore_for_file: public_member_api_docs, sort_constructors_first
//Модель для данных о строе, которая хранит список нот и частот для каждой струны. Это объект, с которым будут работать репозиторий и другие компоненты.
class GuitarTuningModel {
  final List<String> notes;//используем список нот и символов
  final List<double> frequenies;
  GuitarTuningModel({
    required this.notes,
    required this.frequenies,
  });
}
