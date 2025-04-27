import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/feature/tunings/cubit/tuning_state.dart';
import 'package:fluttertuner/feature/tunings/data/models/tuning_model.dart';
import 'package:fluttertuner/feature/tunings/domain/entity/tuning_entity.dart';
import 'package:fluttertuner/feature/tunings/domain/repository/interface/tuning_repository.dart';

class TuningCubit extends Cubit<TuningState> {
  TuningCubit(this._tuningRepository) : super(TuningState.initial());

  final TuningRepository _tuningRepository;

  Future<void> selectTuning(TuningEntity tuning) async {
    await _tuningRepository.selectTuning(tuning);

    emit(state.copyWith(
      tuning: tuning,
    ));
  }

  Future<void> loadTunings() async {
    final tunings = await _tuningRepository.loadCustomTunings();
    emit(state.copyWith(availableTunings: tunings));
  }

  Future<void> deleteTuning(TuningEntity tuning) async {
    await _tuningRepository.deleteTuning(tuning);
    final updatedTunings = await _tuningRepository.loadCustomTunings();
    emit(state.copyWith(availableTunings: updatedTunings));
  }

  Future<void> saveTuning(TuningModel tuning) async {
    await _tuningRepository.saveCustomTuning(tuning);
    final updatedTunings = await _tuningRepository.loadCustomTunings();
    emit(state.copyWith(availableTunings: updatedTunings));
  }
}
