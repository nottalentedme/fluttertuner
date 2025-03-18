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
    return BlocBuilder<MetronomeCubit, MetronomeState>(
        builder: (context, state) {
      // Проверяем текущее состояние иконки
      return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 2, color: Colors.black),
          ),
          padding: const EdgeInsets.all(16.0),
          child: InkWell(
            onTap: () {
              // Переключаем состояние метронома
              context.read<MetronomeCubit>().toggleMetronome();
            },
            child: Icon(
              state.isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
            ),
          ));
    });
  }
}
