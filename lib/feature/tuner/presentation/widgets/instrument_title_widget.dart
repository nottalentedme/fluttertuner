import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/pitch_cubit.dart';
import '../../domain/models/guitar_tuning_model.dart';

class InstrumentTitleWidget extends StatelessWidget {
  const InstrumentTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final currentState = context.watch<PitchCubit>().state;
    // final currentTuning = currentState.currentTuning;

    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          // Выпадающий список для выбора строя
          DropdownButton<GuitarTuning>(
            // value: currentTuning,
            items: [
              GuitarTuning.standard(),
              GuitarTuning.dropD(),
              GuitarTuning.dropC(),
            ].map((tuning) {
              return DropdownMenuItem(
                value: tuning,
                child: Text(
                  tuning.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
            onChanged: (tuning) {
              if (tuning != null) {
                // context.read<PitchCubit>().changeTuning(tuning);
              }
            },
          ),
        ],
      ),
    );
  }
}
