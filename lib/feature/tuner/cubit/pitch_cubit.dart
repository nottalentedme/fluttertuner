// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/feature/tuner/domain/repository/interface/tuning_repository.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'package:pitchupdart/pitch_handler.dart';
import 'package:pitchupdart/tuning_status.dart';

import 'package:fluttertuner/feature/tuner/cubit/tuning_state.dart';
import 'package:fluttertuner/feature/tuner/domain/repository/tuning_repository_impl.dart';
import 'package:fluttertuner/feature/tuner/service/buffer/buffer_service_interface.dart';
import 'package:fluttertuner/feature/tuner/service/recorder/tuner_audio_interface_service.dart';

import '../domain/models/guitar_tuning_model.dart';

class PitchCubit extends Cubit<TuningState> {
  // final AudioRecorderService _audioRecorderService;
  // final PitchDetector _pitchDetector;
  // final BufferService _bufferService;
  // final PitchHandler _pitchHandler;
  StreamSubscription? _tuningResultSubscription;
  final TuningRepository _tuningRepository;

  PitchCubit(
    // this._audioRecorderService,
    // this._pitchDetector,
    // this._bufferService,
    // this._pitchHandler,
    this._tuningRepository,
  ) : super(TuningState.initial()) {
    print('PitchCubit created');
  }
  @override
  Future<void> close() async {
    await stopTuning();
    return super.close();
  }

  Future<void> startTuning() async {
    await _tuningRepository.startAudio();
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
  // }
  // });
//  }

  Future<void> stopTuning() async {
    _tuningResultSubscription?.cancel();
    await _tuningRepository.stopAudio();
  }

  // void changeTuning(GuitarTuning newTuning) {
  //   emit(state.copyWith(
  //     currentTuning: newTuning,
  //     currentStringIndex: 0,
  //   ));
  // }

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
//   //
//   // int getCentsDifference(double detectedFreq, double targetFreq) {
//   //   return (1200 * (log(detectedFreq / targetFreq) / ln2)).round();
//   // }
}

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
