// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:fluttertuner/feature/config/dependency.dart';
import 'package:fluttertuner/feature/tunings/data/models/tuning_model.dart';
import 'package:fluttertuner/feature/tunings/domain/entity/note_entity.dart';

abstract interface class TunerRepository extends Repository {
  Future<void> startAudio();
  Future<void> stopAudio();
  Stream<WrongNoteEntity> get noteStream;
  Future<void> switchMode(TuningMode mode);
  TuningMode get currentMode;
  void setStringIndex(int index);
}
