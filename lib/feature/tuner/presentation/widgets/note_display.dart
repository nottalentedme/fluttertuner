import 'package:flutter/material.dart';

import '../../domain/models/note_model.dart';




class NoteDisplay extends StatelessWidget {
  final NoteModel note;

  const NoteDisplay({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20),
        Text(
          note.note,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        const SizedBox(height: 20),
        Text(
          '${note.frequency.toStringAsFixed(2)} Hz',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
} 