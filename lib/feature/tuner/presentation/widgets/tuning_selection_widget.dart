import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/feature/tuner/cubit/pitch_cubit.dart';
import 'package:fluttertuner/feature/tuner/cubit/tuning_state.dart';
import 'package:fluttertuner/feature/tuner/data/models/note_model.dart';
import 'package:fluttertuner/feature/tuner/data/models/tuning_model.dart';
import 'package:fluttertuner/feature/tuner/presentation/widgets/tuning_add_form.dart';

class TuningSelector extends StatefulWidget {
  const TuningSelector({super.key});

  @override
  State<TuningSelector> createState() => _TuningSelectorState();
}

class _TuningSelectorState extends State<TuningSelector> {
  @override
  void initState() {
    super.initState();
    context.read<PitchCubit>().loadTunings();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PitchCubit, TuningState>(
      builder: (context, state) {
        final tunings = state.availableTunings;

        if (tunings.isEmpty) {
          return const Center(child: Text('No tunings found'));
        }

        return ListView.builder(
          itemCount: tunings.length + 1, // One extra for the "Add" button
          itemBuilder: (context, index) {
            if (index < tunings.length) {
              final tuning = tunings[index];
              final isSelected = tuning.name == state.tuning!.name;

              return ListTile(
                title: Text(tuning.name),
                trailing: isSelected ? const Icon(Icons.check) : null,
                onTap: () {
                  context.read<PitchCubit>().selectTuning(tuning);
                },
              );
            } else {
              // Add Custom Tuning option
              return ListTile(
                leading: const Icon(Icons.add),
                title: const Text('Add Custom Tuning'),
                onTap: () async {
                  final newTuning = await showDialog<TuningModel>(
                    context: context,
                    builder: (context) => const AddTuningDialog(),
                  );

                  if (!context.mounted || newTuning == null) return;

                  context.read<PitchCubit>().saveTuning(newTuning);
                  await context.read<PitchCubit>().loadTunings();
                },
              );
            }
          },
        );
      },
    );
  }
}
