abstract interface class NoteEntity {
  String get name;
  double get frequency;
}

abstract interface class WrongNoteEntity extends NoteEntity {
  double get diffCents;
}
