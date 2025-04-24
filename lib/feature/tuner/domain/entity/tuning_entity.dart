import 'package:fluttertuner/feature/tuner/domain/entity/instrument_entity.dart';
import 'package:fluttertuner/feature/tuner/domain/entity/note_entity.dart';

abstract interface class TuningEntity {
  InstrumentEntity get instrument;
  String get description;
  List<NoteEntity> get notes;
}
