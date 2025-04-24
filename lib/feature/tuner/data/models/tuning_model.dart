import 'package:fluttertuner/feature/tuner/data/models/note_model.dart';
import 'package:fluttertuner/feature/tuner/domain/entity/note_entity.dart';
import 'package:fluttertuner/feature/tuner/domain/entity/tuning_entity.dart';

enum TuningMode {
  chromatic,
  scale,
}

class TuningModel implements TuningEntity {
  const TuningModel({
    required this.name,
    required this.notes,
    this.mode = TuningMode.chromatic,
  });

  @override
  final String name;

  @override
  final List<NoteEntity> notes;

  final TuningMode mode;

  Map<String, dynamic> toJson() => {
        'name': name,
        'mode': mode.name,
        'notes': notes
            .map((note) => {
                  'name': note.name,
                  'frequency': note.frequency,
                })
            .toList(),
      };

  factory TuningModel.fromJson(Map<String, dynamic> json) {
    return TuningModel(
      name: json['name'],
      mode: TuningMode.values.byName(json['mode'] ?? 'scale'),
      notes: (json['notes'] as List)
          .map((n) => NoteModel(
                name: n['name'],
                frequency: n['frequency'],
              ))
          .toList(),
    );
  }
}
