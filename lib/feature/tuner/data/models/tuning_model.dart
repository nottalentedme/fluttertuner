import 'package:fluttertuner/feature/tuner/domain/entity/instrument_entity.dart';
import 'package:fluttertuner/feature/tuner/domain/entity/note_entity.dart';
import 'package:fluttertuner/feature/tuner/domain/entity/tuning_entity.dart';

class TuningModel implements TuningEntity {
  const TuningModel({
    required this.description,
    required this.instrument,
    required this.notes,
  });

  @override
  final String description;

  @override
  final InstrumentEntity instrument;

  @override
  final List<NoteEntity> notes;
}
