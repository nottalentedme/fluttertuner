import 'package:flutter/material.dart';
import 'package:tuner/features/tuner/domain/models/note_model.dart';

class NoteDisplay extends StatelessWidget {
  final NoteModel note;

  const NoteDisplay({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Текущая нота:',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 20),
        Text(
          note.note,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        const SizedBox(height: 20),
        Text(
          'Частота: ${note.frequency.toStringAsFixed(2)} Hz',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
} 