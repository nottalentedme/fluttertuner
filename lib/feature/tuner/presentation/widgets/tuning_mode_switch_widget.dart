import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/core/theme/color_scheme.dart';
import 'package:fluttertuner/feature/tuner/cubit/tuner_cubit.dart';
import 'package:fluttertuner/feature/tuner/cubit/tuner_state.dart';
import 'package:fluttertuner/feature/tunings/data/models/tuning_model.dart';

class TuningModeSwitchWidget extends StatelessWidget {
  const TuningModeSwitchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TunerCubit, TunerState>(
      builder: (context, state) {
        // Определяем активен ли автоматический режим (scale)
        final isAutoMode = state.mode == TuningMode.scale;
        
        return Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const Text(
                'Авто',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColorScheme.primary,
                ),
              ),
              const SizedBox(width: 10),
              Switch(
                value: isAutoMode,
                onChanged: (_) {
                  // При изменении значения переключателя вызываем метод
                  // переключения режима в кубите
                  context.read<TunerCubit>().toggleTuningMode();
                },
                activeTrackColor: AppColorScheme.primary,
              ),
              const SizedBox(width: 10),
              // Добавляем текстовую подсказку о текущем режиме
              Text(
                isAutoMode ? 'Scale' : 'Chromatic',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColorScheme.primary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
