//Интерфейс, описывающий, как будет работать репозиторий. Например, методы получения информации о текущем строе и изменения настроек.

import 'package:fluttertuner/feature/guitar_stroy/domain/models/guitar_tuning_model.dart';

abstract class IGuitarTuningRepository {
  List<GuitarTuningModel> getAvailableTunings();
  List<GuitarTuningModel> getCurrentTuning(int index);
  void changeTuning(int index);
}
