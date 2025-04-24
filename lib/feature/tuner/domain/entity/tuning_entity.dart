import 'package:fluttertuner/feature/tuner/domain/entity/note_entity.dart';

abstract interface class TuningEntity {
  String get name;
  List<NoteEntity> get notes;
}
