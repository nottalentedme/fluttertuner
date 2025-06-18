import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/feature/tuner/cubit/tuner_cubit.dart';
import 'package:fluttertuner/feature/tuner/cubit/tuner_state.dart';
import 'package:fluttertuner/feature/tunings/data/models/tuning_model.dart';

class TuningModeSwitchWidget extends StatelessWidget {
  const TuningModeSwitchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return BlocBuilder<TunerCubit, TunerState>(
      builder: (context, state) {
        // Определяем активен ли автоматический режим (scale)
        final isAutoMode = state.mode == TuningMode.scale;

        return Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.centerRight,
                width: 175,
                child: Text(
                  isAutoMode ? 'Scale' : 'Chromatic',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: theme.onPrimary,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Switch(
                value: isAutoMode,
                onChanged: (_) {
                  // При изменении значения переключателя вызываем метод
                  // переключения режима в кубите
                  context.read<TunerCubit>().toggleTuningMode();
                },
                activeTrackColor: theme.outlineVariant,
                activeColor: theme.surfaceTint,
              ),
            ],
          ),
        );
      },
    );
  }
}
