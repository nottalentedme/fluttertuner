//Обрабатывает события и изменяет состояние приложения.
//Например, если пользователь выбирает новую стройку,
//BLoC обработает это событие и обновит состояние

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/feature/guitar_stroy/domain/repositories/i_guitar_tuning_repository.dart';
import 'package:fluttertuner/feature/guitar_stroy/presentation/bloc/guitar_tuning_event.dart';
import 'package:fluttertuner/feature/guitar_stroy/presentation/bloc/guitar_tuning_state.dart';

class GuitarTuningBloc extends Bloc<GuitarTuningEvent, GuitarTuningState> {
  final IGuitarTuningRepository _repository;

  GuitarTuningBloc(this._repository) : super(GuitarTuningLoading());

  @override
  Stream<GuitarTuningState> mapEventToState(GuitarTuningEvent event) async* {
    if (event is ChangeTuningEvents) {
      yield GuitarTuningLoading();
      try {
        final tuning = _repository.getCurrentTuning(event.index);
        yield GuitarTuningInitial(tuning);
      } catch (e) {
        
      }
    }
  }
}