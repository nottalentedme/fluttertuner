import 'package:flutter/material.dart';
import 'package:fluttertuner/feature/tunings/domain/entity/note_entity.dart';

class TunerTextWidget extends StatelessWidget {
  const TunerTextWidget({
    super.key,
    required this.note,
  });

  final WrongNoteEntity note;

  bool get _isTuned => note.diffCents.abs() <= 5.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                note.name,
                style: TextStyle(
                  color: _isTuned ? theme.secondary : theme.onPrimary,
                  fontSize: 65.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${note.diffCents.toStringAsFixed(1)} cents',
                style: TextStyle(
                  color: theme.onPrimary.withAlpha(100),
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
