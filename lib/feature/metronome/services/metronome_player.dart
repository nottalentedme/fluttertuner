import 'package:audioplayers/audioplayers.dart';

class MetronomePlayer {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final String _soundPath = 'sounds/metronome_click.mp3';

  Future<void> play() async {
    await _audioPlayer.play(AssetSource(_soundPath));
  }

  // почему-то дура лагает в вебе, надо будет затестить на андроид, я так понимаю проблема в HTML5

  void dispose() {
    _audioPlayer.dispose();
  }
}
