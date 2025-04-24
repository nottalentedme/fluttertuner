import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/feature/tuner/cubit/pitch_cubit.dart';
import 'package:fluttertuner/feature/tuner/cubit/tuning_state.dart';
import 'package:fluttertuner/feature/tuner/data/models/note_model.dart';
import 'package:fluttertuner/feature/tuner/data/models/tuning_model.dart';
import 'package:fluttertuner/feature/tuner/domain/models/guitar_tuning_model.dart';

class AddTuningDialog extends StatefulWidget {
  const AddTuningDialog({super.key});

  @override
  State<AddTuningDialog> createState() => _AddTuningDialogState();
}

class _AddTuningDialogState extends State<AddTuningDialog> {
  final _nameController = TextEditingController();
  final List<String> _noteOptions = noteFrequencies.keys.toList();

  final List<String> _selectedNotes = ['E4', 'A4', 'D4', 'G4', 'B4', 'E4'];

  void _addString() {
    setState(() {
      _selectedNotes.add(_noteOptions.first);
    });
  }

  void _removeString(int index) {
    setState(() {
      _selectedNotes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Custom Tuning'),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Tuning Name'),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _selectedNotes.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: _selectedNotes[index],
                            items: _noteOptions.map((note) {
                              return DropdownMenuItem<String>(
                                value: note,
                                child: Text(note),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedNotes[index] = newValue!;
                              });
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () => _removeString(index),
                        ),
                      ],
                    ),
                  );
                },
              ),
              TextButton.icon(
                onPressed: _addString,
                icon: const Icon(Icons.add),
                label: const Text('Add String'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_nameController.text.isNotEmpty && _selectedNotes.isNotEmpty) {
              final tuning = TuningModel(
                name: _nameController.text.trim(),
                notes: _selectedNotes
                    .map((noteStr) => NoteModel(
                          name: noteStr,
                          frequency: noteFrequencies[noteStr] ?? 0.0,
                        ))
                    .toList(),
              );
              Navigator.pop(context, tuning);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
