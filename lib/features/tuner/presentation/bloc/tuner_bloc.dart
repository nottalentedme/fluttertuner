import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuner/features/tuner/domain/repositories/i_tuner_repository.dart';
import 'tuner_event.dart';
import 'tuner_state.dart';

class TunerBloc extends Bloc<TunerEvent, TunerState> {
  final ITunerRepository _repository;
  
  TunerBloc(this._repository) : super(const TunerInitial()) {
    on<StartTuning>(_onStartTuning);
    on<StopTuning>(_onStopTuning);
  }

  Future<void> _onStartTuning(StartTuning event, Emitter<TunerState> emit) async {
    emit(const TunerLoading());
    
    final hasPermission = await _repository.requestMicrophonePermission();
    if (!hasPermission) {
      emit(const TunerError('Для работы тюнера необходим доступ к микрофону'));
      return;
    }

    await emit.forEach(
      _repository.startTuning(),
      onData: (note) => TunerActive(note),
      onError: (error, stackTrace) => TunerError(error.toString()),
    );
  }

  Future<void> _onStopTuning(StopTuning event, Emitter<TunerState> emit) async {
    await _repository.stopTuning();
    emit(const TunerInitial());
  }
} 