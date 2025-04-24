// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/feature/tuner/domain/repository/interface/tuning_repository.dart';
import 'package:pitchupdart/tuning_status.dart';

import 'package:fluttertuner/feature/tuner/cubit/tuning_state.dart';

class TuningCubit extends Cubit<TuningState> {
  StreamSubscription? _tuningResultSubscription;
  final TuningRepository _tuningRepository;

  TuningCubit(
    this._tuningRepository,
  ) : super(TuningState.initial()) {
    print('TuningCubit created');
    startTuning();
  }

  @override
  Future<void> close() async {
    await stopTuning();
    print('TuningCubit destroyed');
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
  }

  Future<void> stopTuning() async {
    _tuningResultSubscription?.cancel();
    await _tuningRepository.stopAudio();
  }
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
