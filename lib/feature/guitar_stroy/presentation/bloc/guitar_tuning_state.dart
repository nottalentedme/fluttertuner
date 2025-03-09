//Хранит возможные состояния (например, загрузка данных о строе, выбран строй и т.д.).
import 'package:fluttertuner/feature/guitar_stroy/domain/models/guitar_tuning_model.dart';

abstract class GuitarTuningState {
  const GuitarTuningState();
}

class GuitarTuningInitial extends GuitarTuningState {
  const GuitarTuningInitial(List<GuitarTuningModel> tuning);
}

class GuitarTuningLoading extends GuitarTuningState {
  const GuitarTuningLoading();
}

class GuitarTuningActive extends GuitarTuningState {
  const GuitarTuningActive();
}

class GuitarTuningError extends GuitarTuningState {
  final GuitarTuningError error;
  const GuitarTuningError(this.error);
}
