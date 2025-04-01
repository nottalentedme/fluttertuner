import 'package:audioplayers/audioplayers.dart';

class MetronomePlayer {
  final AudioPlayer _audioPlayer = AudioPlayer()
    ..setReleaseMode(ReleaseMode.stop);
  static const String _soundPath = 'sounds/metronome_click.mp3';
  bool _isLoaded = false;

  MetronomePlayer() {
    _preload();
  }

  Future<void> _preload() async {
    await _audioPlayer.setSource(AssetSource(_soundPath));
    _isLoaded = true;
  }

  Future<void> play() async {
    if (!_isLoaded) await _preload();
    _audioPlayer.resume();
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
