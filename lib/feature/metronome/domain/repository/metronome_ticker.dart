import 'package:flutter/scheduler.dart';
import 'package:fluttertuner/feature/metronome/domain/repository/interface/metronome_ticker_interface.dart';

class MetronomeTickerImpl implements MetronomeTickerRepository {
  final Ticker _ticker;
  final Stopwatch _stopwatch = Stopwatch();
  final int tempo;
  final void Function() onTick;

  late final int _intervalMs;
  Duration _lastTick = Duration.zero;

  MetronomeTickerImpl({required this.tempo, required this.onTick})
      : _ticker = Ticker(_tick) {
    _intervalMs = (60000 / tempo).round();
  }

  static late MetronomeTickerImpl _instance;

  static void _tick(Duration elapsed) {
    final delta = elapsed - _instance._lastTick;
    if (delta.inMilliseconds >= _instance._intervalMs) {
      _instance._lastTick = elapsed;
      _instance.onTick();
    }
  }

  @override
  void start() {
    _stopwatch.start();
    _lastTick = Duration.zero;
    _ticker.start();
    _instance = this;
  }

  @override
  void stop() {
    _stopwatch.stop();
    _ticker.stop();
  }

  @override
  void dispose() {
    _ticker.dispose();
  }
}
