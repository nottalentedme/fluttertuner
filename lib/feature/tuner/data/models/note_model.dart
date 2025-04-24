import 'package:fluttertuner/feature/tuner/domain/entity/note_entity.dart';
import 'package:fluttertuner/feature/tuner/domain/models/guitar_tuning_model.dart';
import 'package:pitchupdart/pitch_result.dart';

class NoteModel implements NoteEntity {
  const NoteModel({
    required this.frequency,
    required this.name,
  });

  factory NoteModel.from(PitchResult pitchResult) {
    return NoteModel(
      frequency: pitchResult.expectedFrequency,
      name: pitchResult.note,
    );
  }

  factory NoteModel.fromName(String name) {
    final matching = noteFrequencies.entries
        .where((entry) => entry.key.startsWith(name))
        .toList();

    if (matching.isNotEmpty) {
      final match = matching.first;
      return NoteModel(name: match.key, frequency: match.value);
    }

    return NoteModel(name: name, frequency: 0.0);
  }

  @override
  final double frequency;

  @override
  final String name;
}

class WrongNoteModel extends NoteModel implements WrongNoteEntity {
  const WrongNoteModel({
    required this.diffCents,
    required super.frequency,
    required super.name,
  });

  factory WrongNoteModel.fromNote({
    required NoteEntity note,
    required double diffCents,
  }) {
    return WrongNoteModel(
      diffCents: diffCents,
      frequency: note.frequency,
      name: note.name,
    );
  }

  factory WrongNoteModel.fromPitchResult(PitchResult pitchResult) {
    return WrongNoteModel.fromNote(
      note: NoteModel.from(pitchResult),
      diffCents: pitchResult.diffCents,
    );
  }

  @override
  final double diffCents;
}
