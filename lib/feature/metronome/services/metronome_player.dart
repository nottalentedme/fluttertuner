import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_soloud/flutter_soloud.dart';
import 'package:fluttertuner/core/di/dependency.dart';

class MetronomePlayer extends Service {
  final SoLoud _soloud = SoLoud.instance;
  late final AudioSource _clickSound;
  bool _isLoaded = false;

  MetronomePlayer() {
    _preload();
  }

  Future<void> _preload() async {
    await _soloud.init();

    final ByteData data =
        await rootBundle.load('assets/sounds/metronome_click.wav');
    final Uint8List buffer = data.buffer.asUint8List();
    _clickSound = await _soloud.loadMem(
        'assets/sounds/metronome_click.wav', buffer,
        mode: LoadMode.disk);
    _isLoaded = true;
  }

  Future<void> play() async {
    if (_isLoaded) {
      _soloud.play(_clickSound);
    }
  }

  void dispose() {
    _soloud.deinit();
  }
}
