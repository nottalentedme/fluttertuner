// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/feature/tunings/data/models/tuning_model.dart';
import 'package:fluttertuner/feature/tuner/domain/repository/interface/tuner_repository.dart';

import 'package:fluttertuner/feature/tuner/cubit/tuner_state.dart';
import 'package:fluttertuner/feature/tunings/domain/entity/tuning_entity.dart';
import 'package:fluttertuner/feature/tunings/domain/repository/interface/tuning_repository.dart';

class TunerCubit extends Cubit<TunerState> {
  StreamSubscription? _tuningResultSubscription;
  final TunerRepository _tunerRepository;
  final TuningRepository _tuningRepository;

  TunerCubit(
    this._tunerRepository,
    this._tuningRepository,
  ) : super(TunerState.initial()) {
    startTuning();
  }

  @override
  Future<void> close() async {
    await stopTuning();
    return super.close();
  }

  Future<void> startTuning() async {
    await _tunerRepository.startAudio();
    final currentTuning = _tuningRepository.currentTuning;
    final mode = _tunerRepository.currentMode;
    emit(state.copyWith(
      tuning: currentTuning,
      currentStringIndex: 0,
      mode: mode,
    ));

    _tuningResultSubscription = _tunerRepository.noteStream.listen(
      (event) {
        emit(state.copyWith(
          note: event,
        ));
      },
    );
  }

  Future<void> stopTuning() async {
    _tuningResultSubscription?.cancel();
    await _tunerRepository.stopAudio();
  }
//!!! вынести в tuning cubit
  // Future<void> selectTuning(TuningEntity tuning) async {
  //   await _tuningRepository.selectTuning(tuning);

  //   emit(state.copyWith(
  //     tuning: tuning,
  //     currentStringIndex: 0,
  //     targetNote: tuning.notes.isNotEmpty ? tuning.notes[0] : state.targetNote,
  //   ));
  // }

  void changeString(int newIndex) {
    _tunerRepository.setStringIndex(newIndex);
    emit(state.copyWith(
      currentStringIndex: newIndex,
      targetNote: state.tuning?.notes[newIndex],
    ));
  }
//!!! вынести в tuning cubit
  // Future<void> loadTunings() async {
  //   final tunings = await _tuningRepository.loadCustomTunings();
  //   emit(state.copyWith(availableTunings: tunings));
  // }
//!!! вынести в tuning cubit
  // Future<void> saveTuning(TuningModel tuning) async {
  //   await _tuningRepository.saveCustomTuning(tuning);
  //   final updatedTunings = await _tuningRepository.loadCustomTunings();
  //   emit(state.copyWith(availableTunings: updatedTunings));
  // }

  void toggleTuningMode() async {
    final newMode = state.mode == TuningMode.scale
        ? TuningMode.chromatic
        : TuningMode.scale;

    _tunerRepository.switchMode(newMode);
    emit(state.copyWith(mode: newMode));
  }
}
