//Содержит логику для получения и изменения данных о гитарных строях ( возвращает список доступных строев или изменяет текущий строй).

import 'package:fluttertuner/feature/guitar_stroy/domain/models/guitar_tuning_model.dart';

class GuitarTuningRepository {
  List<GuitarTuningModel> availableTunings = [
    GuitarTuningModel(
      notes: ['E', 'A', 'D', 'G', 'B', 'E'],
      frequenies: [82.41, 110.00, 146.83, 196.00, 246.94, 329.63],
    ),
    GuitarTuningModel(
      notes: ['D', 'G', 'C', 'F', 'A', 'D'],
      frequenies: [73.42, 98.00, 130.81, 174.61, 220.00, 293.66],
    ),
  ];//наличие 2-х моделей

  GuitarTuningModel getCurrentTuning(int index) {
    return availableTunings[index];
  }

  void changeTuning(int index) {
    // логика для смены строя
  }
}