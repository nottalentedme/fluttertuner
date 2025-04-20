// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:fluttertuner/feature/config/dependency.dart';
import 'package:fluttertuner/feature/tuner/domain/entity/note_entity.dart';

abstract interface class TuningRepository extends Repository {
  Future<void> startAudio();
  Future<void> stopAudio();
  Stream<WrongNoteEntity> get noteStream;
}
