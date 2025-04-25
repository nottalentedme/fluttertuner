import 'package:fluttertuner/feature/tunings/data/constants/tuning_presets.dart';
import 'package:fluttertuner/feature/tunings/data/models/tuning_model.dart';
import 'package:fluttertuner/feature/tunings/domain/entity/tuning_entity.dart';
import 'package:fluttertuner/feature/tunings/service/tuning_storage/tuning_storage.dart';
import 'package:fluttertuner/feature/tunings/domain/entity/note_entity.dart';
import 'package:fluttertuner/feature/tunings/domain/repository/interface/tuning_repository.dart';

class TuningRepositoryImpl implements TuningRepository {
  TuningRepositoryImpl(this._tuningStorage);

  final TuningStorage _tuningStorage;
  TuningEntity _currentTuning = TuningPresets.standardTuning;

  @override
  TuningEntity get currentTuning => _currentTuning;

  @override
  Future<List<TuningModel>> loadCustomTunings() async {
    final customTunings = await _tuningStorage.loadCustomTunings();

    return [
      ...TuningPresets.defaultTunings,
      ...customTunings,
    ];
  }

  @override
  Future<void> saveCustomTuning(TuningModel tuning) async {
    _tuningStorage.saveCustomTuning(tuning);
  }

  @override
  Future<void> selectTuning(TuningModel tuning) async {
    _currentTuning = tuning;
  }

  @override
  NoteEntity getNearest(int currentStringIndex) {
    final nearest = currentTuning.notes[currentStringIndex];
    return nearest;
  }
}
