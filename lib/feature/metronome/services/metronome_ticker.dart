import 'package:flutter/scheduler.dart';

class MetronomeTicker {
  final Ticker _ticker;
  final int tempo;
  final void Function() onTick;

  late final int _intervalMs;
  Duration _lastTick = Duration.zero;

  MetronomeTicker({required this.tempo, required this.onTick})
      : _ticker = Ticker(_tick) {
    _intervalMs = (60000 / tempo).round();
  }

  static late MetronomeTicker _instance;

  static void _tick(Duration elapsed) {
    final delta = elapsed - _instance._lastTick;
    if (delta.inMilliseconds >= _instance._intervalMs) {
      _instance._lastTick = elapsed;
      _instance.onTick();
    }
  }

  void start() {
    _lastTick = Duration.zero;
    _ticker.start();
    _instance = this;
  }

  void stop() {
    _ticker.stop();
  }

  void dispose() {
    _ticker.dispose();
  }
}
