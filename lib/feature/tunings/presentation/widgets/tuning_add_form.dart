import 'package:flutter/material.dart';
import 'package:fluttertuner/feature/tunings/data/models/note_model.dart';
import 'package:fluttertuner/feature/tunings/data/models/tuning_model.dart';
import 'package:fluttertuner/feature/tunings/data/constants/note_data.dart';

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
    if (_selectedNotes.length < 9) {
      setState(() {
        _selectedNotes.add(_noteOptions.first);
      });
    }
  }

  void _removeString(int index) {
    if (_selectedNotes.length > 3) {
      setState(() {
        _selectedNotes.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return AlertDialog(
      title: Text(
        'Add Custom Tuning',
        style: TextStyle(color: theme.onPrimary),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Tuning Name'),
                style: TextStyle(color: theme.onPrimary),
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
                                child: Text(
                                  note,
                                  style: TextStyle(
                                      color: theme.onPrimary, fontSize: 24),
                                ),
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
                          icon: Icon(
                            Icons.remove_circle_outline,
                            color: _selectedNotes.length > 3
                                ? theme.secondary
                                : theme.onPrimary.withValues(alpha: 0.5),
                          ),
                          onPressed: () => _removeString(index),
                        ),
                      ],
                    ),
                  );
                },
              ),
              TextButton.icon(
                onPressed: _addString,
                icon: Icon(
                  Icons.add,
                  color: _selectedNotes.length < 9
                      ? theme.secondary
                      : theme.onPrimary.withValues(alpha: 0.5),
                ),
                label: Text(
                  'Add String',
                  style: TextStyle(
                    color: _selectedNotes.length < 9
                        ? theme.onPrimary
                        : theme.onPrimary.withValues(alpha: 0.5),
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: TextStyle(color: theme.onPrimary, fontSize: 20),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: theme.secondary),
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
          child: Text(
            'Save',
            style: TextStyle(
                color: theme.primary,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
