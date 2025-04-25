import 'package:fluttertuner/feature/config/dependency.dart';
import 'package:fluttertuner/feature/tunings/data/models/tuning_model.dart';
import 'package:fluttertuner/feature/tunings/domain/entity/note_entity.dart';
import 'package:fluttertuner/feature/tunings/domain/entity/tuning_entity.dart';

abstract interface class TuningRepository extends Repository {
  ///
  ///Сохраняет пользовательский строй
  ///
  Future<void> saveCustomTuning(TuningModel tuning);

  ///
  ///Загружает все строи(дефолтные и пользовательские)
  ///
  Future<List<TuningModel>> loadCustomTunings();

  ///
  ///Метод выбора строя [tuning] - строй
  ///
  Future<void> selectTuning(TuningModel tuning);

  ///
  ///Получает ближайшую ноту из строя по индексу струны
  ///[currentStringIndex] - индекс текущей струны
  ///
  NoteEntity getNearest(int currentStringIndex);

  TuningEntity get currentTuning;
}
