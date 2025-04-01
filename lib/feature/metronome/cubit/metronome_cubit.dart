import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/feature/metronome/cubit/metronome_state.dart';
import 'package:fluttertuner/feature/metronome/services/metronome_player.dart';

class MetronomeCubit extends Cubit<MetronomeState> {
  final MetronomePlayer _metronomePlayer = MetronomePlayer();
  Timer? _timer;
  final List<DateTime> _tapTimes = [];

  MetronomeCubit() : super(MetronomeState.initial()) {
    print('MetronomeCubit created');
  }

  void setTempo(int tempo) {
    if (state.tempo == tempo) return;
    emit(state.copyWith(tempo: tempo));
    if (state.isRunning) {
      _restartTimer();
    }
  }

  void toggleMetronome() {
    final isRunning = !state.isRunning;
    emit(state.copyWith(isRunning: isRunning));
    if (isRunning) {
      _startTimer();
    } else {
      _stopTimer();
    }
  }

  void _startTimer() {
    _stopTimer();
    _timer = Timer.periodic(
      Duration(milliseconds: (60000 / state.tempo).round()),
      (timer) {
        _metronomePlayer.play();
      },
    );
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _restartTimer() {
    if (state.isRunning) {
      _stopTimer();
      _startTimer();
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
      emit(state.copyWith(tempo: bpm));
    }
  }

  @override
  Future<void> close() {
    _stopTimer();
    print('MetronomeCubit destroyed');
    _metronomePlayer.dispose();
    return super.close();
  }
}
