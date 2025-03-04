import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'dart:math';
import 'dart:async';
import 'dart:typed_data';
import 'package:record/record.dart';

class GuitarTuner extends StatefulWidget {
  const GuitarTuner({super.key});

  @override
  State<GuitarTuner> createState() => _GuitarTunerState();
}

class _GuitarTunerState extends State<GuitarTuner> {
  final _audioRecorder = AudioRecorder();
  late final PitchDetector _pitchDetector;
  String _note = "-";
  double _frequency = 0.0;
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _initializeTuner();
  }

  Future<void> _initializeTuner() async {
    final status = await Permission.microphone.request();
    if (status.isGranted) {
      _startRecording();
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Для работы тюнера необходим доступ к микрофону'),
          ),
        );
      }
    }
  }

  Future<void> _startRecording() async {
    try {
      _pitchDetector = PitchDetector();

      final recordStream = await _audioRecorder.startStream(
        const RecordConfig(
          encoder: AudioEncoder.pcm16bits,
          numChannels: 1,
          sampleRate: 44100,
          bitRate: 128000,
        ),
      );

      recordStream.listen((samples) async {
        if (samples.length >= 2048) {
          final intBuffer = Uint8List.fromList(samples);
          final pitch = await _pitchDetector.getPitchFromIntBuffer(intBuffer);
          if (pitch.pitched && pitch.pitch >= 80 && pitch.pitch <= 1200) {
            setState(() {
              _frequency = pitch.pitch;
              _note = _getNoteFromFrequency(pitch.pitch);
            });
          }
        }
      });

      setState(() {
        _isRecording = true;
      });
    } catch (e) {
      debugPrint('Error starting recording: $e');
    }
  }

  String _getNoteFromFrequency(double frequency) {
    const notes = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B'];
    final hz = 440;
    final steps = (12 * (log(frequency / hz) / log(2))).round();
    final octave = ((log(frequency / 440) / log(2)) * 12 + 57) ~/ 12;
    final noteIndex = (steps % 12 + 12) % 12;
    return '${notes[noteIndex]}$octave';
  }

  void _stopRecording() async {
    await _audioRecorder.stop();
    setState(() {
      _isRecording = false;
    });
  }

  @override
  void dispose() {
    _stopRecording();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Гитарный тюнер'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Текущая нота:',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Text(
              _note,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 20),
            Text(
              'Частота: ${_frequency.toStringAsFixed(2)} Hz',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_isRecording) {
                  _stopRecording();
                } else {
                  _startRecording();
                }
              },
              child: Text(_isRecording ? 'Остановить' : 'Начать'),
            ),
          ],
        ),
      ),
    );
  }
} 