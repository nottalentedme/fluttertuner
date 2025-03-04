import 'package:permission_handler/permission_handler.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'package:record/record.dart';
import 'dart:math';
import 'dart:typed_data';

import '../../domain/models/note_model.dart';
import '../../domain/repositories/i_tuner_repository.dart';

class TunerRepository implements ITunerRepository {
  final _audioRecorder = AudioRecorder();
  final _pitchDetector = PitchDetector();

  @override
  Future<bool> requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  @override
  Stream<NoteModel> startTuning() async* {
    final recordStream = await _audioRecorder.startStream(
      const RecordConfig(
        encoder: AudioEncoder.pcm16bits,
        numChannels: 1,
        sampleRate: 44100,
        bitRate: 128000,
      ),
    );

    await for (final samples in recordStream) {
      if (samples.length >= 2048) {
        try {
          final intBuffer = Uint8List.fromList(samples);
          final pitch = await _pitchDetector.getPitchFromIntBuffer(intBuffer);
          if (pitch.pitched && pitch.pitch >= 80 && pitch.pitch <= 1200) {
            yield NoteModel(
              note: _getNoteFromFrequency(pitch.pitch),
              frequency: pitch.pitch,
            );
          }
        } catch (e) {
          print('Error processing audio buffer: $e');
          continue;
        }
      }
    }
  }

  String _getNoteFromFrequency(double frequency) {
    const notes = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B'];
    
    // A4 = 440 Hz
    final a = 440.0;
    
    // Вычисляем количество полутонов от A4
    final n = 12 * (log(frequency / a) / log(2));
    
    // Округляем до ближайшего полутона
    final halfSteps = n.round();
    
    // Вычисляем индекс ноты (0-11)
    final noteIndex = (halfSteps + 9) % 12;
    
    // Вычисляем октаву
    final octave = ((halfSteps + 9) / 12 + 4).floor();
    
    return '${notes[noteIndex]}$octave';
  }

  @override
  Future<void> stopTuning() async {
    await _audioRecorder.stop();
  }
} 