// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/feature/tuner/data/models/tuning_model.dart';
import 'package:fluttertuner/feature/tuner/domain/repository/interface/tuning_repository.dart';
import 'package:pitchupdart/tuning_status.dart';

import 'package:fluttertuner/feature/tuner/cubit/tuning_state.dart';

class PitchCubit extends Cubit<TuningState> {
  StreamSubscription? _tuningResultSubscription;
  final TuningRepository _tuningRepository;

  PitchCubit(
    this._tuningRepository,
  ) : super(TuningState.initial()) {
    print('PitchCubit created');
    startTuning();
  }

  @override
  Future<void> close() async {
    await stopTuning();
    return super.close();
  }

  Future<void> startTuning() async {
    await _tuningRepository.startAudio();
    final currentTuning = _tuningRepository.currentTuning;
    final mode = _tuningRepository.currentMode;
    emit(state.copyWith(
      tuning: currentTuning,
      currentStringIndex: 0,
      mode: mode,
    ));

    _tuningResultSubscription = _tuningRepository.noteStream.listen(
      (event) {
        emit(state.copyWith(
          note: event,
        ));
      },
    );

    //организовать стрим в виде нот
    //ожидаемая нота, текущая нота, разница в центах
    //

    // // Автоопределение ближайшей струны
    // final closestIndex =
    //     findClosestStringIndex(state.currentTuning, currentFreq);
    // final expectedNote = state.currentTuning.strings[closestIndex];
    // final expectedFrequency = noteFrequencies[expectedNote];

    // if (expectedFrequency != null) {
    //   final diff = currentFreq - expectedFrequency;
    //   final cents = getCentsDifference(currentFreq, expectedFrequency);
  }

  Future<void> stopTuning() async {
    _tuningResultSubscription?.cancel();
    await _tuningRepository.stopAudio();
  }

  Future<void> selectTuning(TuningModel tuning) async {
    await _tuningRepository.selectTuning(tuning);

    emit(state.copyWith(
      tuning: tuning,
      currentStringIndex: 0,
      targetNote: tuning.notes.isNotEmpty ? tuning.notes[0] : state.targetNote,
    ));
  }

  void changeString(int newIndex) {
    emit(state.copyWith(
      currentStringIndex: newIndex,
      targetNote: state.tuning.notes[newIndex],
    ));
  }

  Future<void> loadTunings() async {
    final tunings = await _tuningRepository.loadCustomTunings();
    emit(state.copyWith(availableTunings: tunings));
  }

  Future<void> saveTuning(TuningModel tuning) async {
    await _tuningRepository.saveCustomTuning(tuning);
    final updatedTunings = await _tuningRepository.loadCustomTunings();
    emit(state.copyWith(availableTunings: updatedTunings));
  }

  void toggleTuningMode() {
    final newMode = state.mode == TuningMode.scale
        ? TuningMode.chromatic
        : TuningMode.scale;

    _tuningRepository.switchMode(newMode);
    emit(state.copyWith(mode: newMode));
  }

  Future<void> _resetTuning() async {
    await stopTuning();
    await startTuning();
  }
}

//   void nextString() {
//     if (state.currentStringIndex < state.currentTuning.strings.length - 1) {
//       emit(state.copyWith(
//         currentStringIndex: state.currentStringIndex + 1,
//       ));
//     }
//   }

//   void previousString() {
//     if (state.currentStringIndex > 0) {
//       emit(state.copyWith(
//         currentStringIndex: state.currentStringIndex - 1,
//       ));
//     }
//   }

//   String getCurrentTargetNote() {
//     return state.currentTuning.strings[state.currentStringIndex];
//   }
//
// int getCentsDifference(double detectedFreq, double targetFreq) {
//   return (1200 * (log(detectedFreq / targetFreq) / ln2)).round();
// }

extension Description on TuningStatus {
  String getDescription() => switch (this) {
        TuningStatus.tuned => "Настроено",
        TuningStatus.toolow => "Низко",
        TuningStatus.toohigh => "Высоко",
        TuningStatus.waytoolow => "Слишком низко",
        TuningStatus.waytoohigh => "Слишком высоко",
        TuningStatus.undefined => "Нота не определена",
      };
}
