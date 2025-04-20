import 'dart:async';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/feature/metronome/cubit/metronome_state.dart';
import 'package:fluttertuner/feature/metronome/domain/repository/interface/metronome_ticker_interface.dart';
import 'package:fluttertuner/feature/metronome/services/metronome_player.dart';
import 'package:fluttertuner/feature/metronome/domain/repository/metronome_ticker.dart';

class MetronomeCubit extends Cubit<MetronomeState> {
  final MetronomePlayer _metronomePlayer = MetronomePlayer();
  MetronomeTickerRepository? _ticker;
  final List<DateTime> _tapTimes = [];

  MetronomeCubit() : super(MetronomeState.initial()) {
    print('MetronomeCubit created');
  }

  void setTempo(int tempo) {
    if (state.tempo == tempo) return;
    emit(state.copyWith(tempo: tempo));
    if (state.isRunning) {
      _restartTicker();
    }
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
    _stopTicker();
    _ticker = MetronomeTickerImpl(
      tempo: state.tempo,
      onTick: () => _metronomePlayer.play(),
    )..start();
  }

  void _stopTicker() {
    _ticker?.stop();
    _ticker?.dispose();
    _ticker = null;
  }

  void _restartTicker() {
    if (state.isRunning) {
      _stopTicker();
      _startTicker();
    }
  }

  void registerTap() {
    final now = DateTime.now();
    if (_tapTimes.isNotEmpty && now.difference(_tapTimes.last).inSeconds > 2) {
      _tapTimes.clear();
    }
    _tapTimes.add(now);
    if (_tapTimes.length > 4) {
      _tapTimes.removeAt(0);
    }

    if (_tapTimes.length > 1) {
      final intervals = _tapTimes
          .asMap()
          .entries
          .skip(1)
          .map((e) => e.value.difference(_tapTimes[e.key - 1]).inMilliseconds);
      final avgInterval = intervals.reduce((a, b) => a + b) / intervals.length;
      final bpm = (60000 / avgInterval).round();
      final cappedBpm = min(bpm, 200);
      emit(state.copyWith(tempo: cappedBpm));
    }
  }

  @override
  Future<void> close() {
    _stopTicker();
    _metronomePlayer.dispose();
    print('MetronomeCubit destroyed');
    return super.close();
  }
}
