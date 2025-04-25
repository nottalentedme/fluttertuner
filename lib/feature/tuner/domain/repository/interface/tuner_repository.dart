// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:fluttertuner/feature/config/dependency.dart';
import 'package:fluttertuner/feature/tunings/data/models/tuning_model.dart';
import 'package:fluttertuner/feature/tunings/domain/entity/note_entity.dart';

abstract interface class TunerRepository extends Repository {
  Stream<WrongNoteEntity> get noteStream;

  ///
  ///Начинает стрим с записью
  Future<void> startAudio();

  ///
  ///Останавливает стрим с записью
  Future<void> stopAudio();

  ///
  ///Меняет режим настройки [mode]
  ///(Хроматический либо по строю)
  Future<void> switchMode(TuningMode mode);
  TuningMode get currentMode;

  ///
  ///Устанавливает струну по индексу [index]
  void setStringIndex(int index);
}
