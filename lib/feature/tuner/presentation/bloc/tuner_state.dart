

import '../../domain/models/note_model.dart';

abstract class TunerState {
  const TunerState();
}

class TunerInitial extends TunerState {
  const TunerInitial();
}

class TunerLoading extends TunerState {
  const TunerLoading();
}

class TunerActive extends TunerState {
  final NoteModel note;
  const TunerActive(this.note);
}

class TunerError extends TunerState {
  final String message;
  const TunerError(this.message);
} 