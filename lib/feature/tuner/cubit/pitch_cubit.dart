import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/feature/tuner/cubit/tuning_state.dart';
import 'package:fluttertuner/feature/tuner/service/buffer/buffer_service_interface.dart';
import 'package:fluttertuner/feature/tuner/service/recorder/tuner_audio_interface_service.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'package:pitchupdart/pitch_handler.dart';
import 'package:pitchupdart/tuning_status.dart';
import '../domain/models/guitar_tuning_model.dart';

class PitchCubit extends Cubit<TuningState> {
  final AudioRecorderService _audioRecorderService;
  final PitchDetector _pitchDetector;
  final BufferService _bufferService;
  final PitchHandler _pitchHandler;
  StreamSubscription? _audioStreamSubscription;

  PitchCubit(
    this._audioRecorderService,
    this._pitchDetector,
    this._bufferService,
    this._pitchHandler,
  ) : super(TuningState(
          note: "N/A",
          frequency: 0.0,
          diffFrequency: 0.0,
          centsDiff: 0,
          targetNote: "E2",
          targetFrequency: 82.41,
          currentTuning: GuitarTuning.standard(),
          currentStringIndex: 0,
        )) {
    print('PitchCubit created');
  }

  Future<void> startTuning() async {
    final recordStream = await _audioRecorderService.startRecording();
    var audioSampleBufferedStream = _bufferService.toBuffer(recordStream);

    _audioStreamSubscription =
        audioSampleBufferedStream.listen((audioSample) async {
      final intBuffer = Uint8List.fromList(audioSample);

      final detectedPitch =
          await _pitchDetector.getPitchFromIntBuffer(intBuffer);
      if (detectedPitch.pitched) {
        final currentFreq = detectedPitch.pitch;
        final pitchResult = await _pitchHandler.handlePitch(currentFreq);

        // Автоопределение ближайшей струны
        final closestIndex =
            findClosestStringIndex(state.currentTuning, currentFreq);
        final expectedNote = state.currentTuning.strings[closestIndex];
        final expectedFrequency = noteFrequencies[expectedNote];

        if (expectedFrequency != null) {
          final diff = currentFreq - expectedFrequency;
          final cents = getCentsDifference(currentFreq, expectedFrequency);

          emit(state.copyWith(
            note: pitchResult.note,
            frequency: currentFreq,
            diffFrequency: diff,
            centsDiff: cents,
            targetNote: expectedNote,
            targetFrequency: expectedFrequency,
            currentStringIndex: closestIndex,
          ));
        }
      }
    });
  }

  Future<void> stopTuning() async {
    await _audioStreamSubscription?.cancel();
    await _audioRecorderService.stopRecording();
  }

  void changeTuning(GuitarTuning newTuning) {
    emit(state.copyWith(
      currentTuning: newTuning,
      currentStringIndex: 0,
    ));
  }

  void nextString() {
    if (state.currentStringIndex < state.currentTuning.strings.length - 1) {
      emit(state.copyWith(
        currentStringIndex: state.currentStringIndex + 1,
      ));
    }
  }

  void previousString() {
    if (state.currentStringIndex > 0) {
      emit(state.copyWith(
        currentStringIndex: state.currentStringIndex - 1,
      ));
    }
  }

  String getCurrentTargetNote() {
    return state.currentTuning.strings[state.currentStringIndex];
  }

  int getCentsDifference(double detectedFreq, double targetFreq) {
    return (1200 * (log(detectedFreq / targetFreq) / ln2)).round();
  }
}

extension Description on TuningStatus {
  String getDescription() => switch (this) {
        TuningStatus.tuned => "Настроено",
        TuningStatus.toolow => "Низко",
        TuningStatus.toohigh => "Высоко",
        TuningStatus.waytoolow => "Слишком низко",
        TuningStatus.waytoohigh => "Слишком высоко",
        TuningStatus.undefined => "Нота не определена",
      };
}
