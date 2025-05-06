import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/feature/tunings/cubit/tuning_cubit.dart';
import 'package:fluttertuner/feature/tunings/cubit/tuning_state.dart';
import 'package:fluttertuner/feature/tunings/data/constants/tuning_presets.dart';
import 'package:fluttertuner/feature/tunings/data/models/tuning_model.dart';
import 'package:fluttertuner/feature/tunings/presentation/widgets/tuning_add_form.dart';

class TuningSelectionWidget extends StatefulWidget {
  const TuningSelectionWidget({super.key});

  @override
  State<TuningSelectionWidget> createState() => _TuningSelectionWidgetState();
}

class _TuningSelectionWidgetState extends State<TuningSelectionWidget> {
  @override
  void initState() {
    super.initState();
    context.read<TuningCubit>().loadTunings();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return BlocBuilder<TuningCubit, TuningState>(
      builder: (context, state) {
        final tunings = state.availableTunings;

        if (tunings.isEmpty) {
          return const Center(child: Text('No tunings found'));
        }

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: theme.primary,
            child: Icon(
              Icons.add,
              color: theme.secondary,
            ),
            onPressed: () async {
              final newTuning = await showDialog<TuningModel>(
                context: context,
                builder: (context) => const AddTuningDialog(),
              );

              if (!context.mounted || newTuning == null) return;

              context.read<TuningCubit>().saveTuning(newTuning);
              await context.read<TuningCubit>().loadTunings();
            },
          ),
          body: ListView.builder(
            padding: const EdgeInsets.only(bottom: 96),
            itemCount: tunings.length + 1, // One extra for the "Add" button
            itemBuilder: (context, index) {
              if (index < tunings.length) {
                final tuning = tunings[index];
                final isSelected = tuning.name == state.tuning?.name;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 2,
                    child: ListTile(
                      title: Text(
                        tuning.name,
                        style: const TextStyle(fontSize: 24),
                      ),
                      leading: isSelected ? const Icon(Icons.check) : null,
                      trailing: index >= TuningPresets.defaultTunings.length
                          ? IconButton(
                              onPressed: () {
                                context
                                    .read<TuningCubit>()
                                    .deleteTuning(tuning);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: theme.secondary,
                              ),
                            )
                          : null,
                      onTap: () {
                        context.read<TuningCubit>().selectTuning(tuning);
                      },
                    ),
                  ),
                );
              } else {
                // Add Custom Tuning option
                // return ListTile(
                //   leading: const Icon(Icons.add),
                //   title: const Text('Add Custom Tuning'),
                //   onTap: () async {
                //     final newTuning = await showDialog<TuningModel>(
                //       context: context,
                //       builder: (context) => const AddTuningDialog(),
                //     );

                //     if (!context.mounted || newTuning == null) return;

                //     context.read<TuningCubit>().saveTuning(newTuning);
                //     await context.read<TuningCubit>().loadTunings();
                //   },
                // );
              }
            },
          ),
        );
      },
    );
  }
}
