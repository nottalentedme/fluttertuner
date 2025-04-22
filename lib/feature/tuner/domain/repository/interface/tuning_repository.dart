// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:fluttertuner/feature/config/dependency.dart';
import 'package:fluttertuner/feature/tuner/data/models/note_model.dart';
import 'package:fluttertuner/feature/tuner/data/models/tuning_model.dart';
import 'package:fluttertuner/feature/tuner/domain/entity/note_entity.dart';

abstract interface class TuningRepository extends Repository {
  Future<void> startAudio();
  Future<void> stopAudio();
  Stream<WrongNoteEntity> get noteStream;
  Future<void> saveCustomTuning(TuningModel tuning);
  Future<List<TuningModel>> loadCustomTunings();
  Future<void> selectTuning(TuningModel tuning);
  TuningModel get currentTuning;
  Future<void> switchMode(TuningMode mode);
  NoteModel findNearestNote(double frequency);
  TuningMode get currentMode;
}
