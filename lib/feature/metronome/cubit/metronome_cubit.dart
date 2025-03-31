import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/feature/metronome/cubit/metronome_state.dart';
import 'package:fluttertuner/feature/metronome/services/metronome_player.dart';

class MetronomeCubit extends Cubit<MetronomeState> {
  final MetronomePlayer _metronomePlayer = MetronomePlayer();
  Ticker? _ticker;
  int _tickCount = 0;

  MetronomeCubit() : super(MetronomeState.initial()) {
    print('MetronomeCubit created');
  }

  void setTempo(int tempo) {
    emit(state.copyWith(tempo: tempo));
    _restartTicker();
  }

  void toggleMetronome() {
    final isRunning = !state.isRunning;
    emit(state.copyWith(isRunning: isRunning));
    if (isRunning) {
      _startTicker();
    } else {
      _stopTicker();
    }
  }

  void _startTicker() {
    _ticker = Ticker((elapsed) {
      _tickCount++;
      if (_tickCount % (60 / (state.tempo / 60)).round() == 0) {
        _metronomePlayer.play();
      }
    });
    _ticker?.start();
  }

  void _stopTicker() {
    _ticker?.stop();
    _ticker = null;
    _tickCount = 0;
  }

  void _restartTicker() {
    if (state.isRunning) {
      _stopTicker();
      _startTicker();
    }
  }

  @override
  Future<void> close() {
    _stopTicker();
    print('MetronomeCubit destroyed');
    _metronomePlayer.dispose();
    return super.close();
  }
}
