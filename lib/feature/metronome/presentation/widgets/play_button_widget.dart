import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/feature/metronome/cubit/metronome_cubit.dart';
import 'package:fluttertuner/feature/metronome/cubit/metronome_state.dart';

class PlayButtonWidget extends StatelessWidget {
  const PlayButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return BlocBuilder<MetronomeCubit, MetronomeState>(
      builder: (context, state) {
        // Проверяем текущее состояние иконки
        return InkWell(
          customBorder: const CircleBorder(),
          onTap: () {
            // Переключаем состояние метронома
            context.read<MetronomeCubit>().toggleMetronome();
          },
          child: Container(
            decoration: BoxDecoration(
              color: theme.outlineVariant,
              shape: BoxShape.circle,
              border: Border.all(width: 2, color: theme.outline),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Icon(
              state.isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
              color: theme.onTertiary,
            ),
          ),
        );
      },
    );
  }
}
