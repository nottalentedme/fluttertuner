import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/feature/metronome/cubit/metronome_cubit.dart';
import 'package:fluttertuner/feature/metronome/cubit/metronome_state.dart';

class MetronomePage extends StatelessWidget {
  const MetronomePage({super.key});

  static const path = '/metronome';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MetronomeCubit, MetronomeState>(
      builder: (context, state) {
        return Column(
          children: [
            Text('Tempo: ${state.tempo} BPM'),
            Slider(
              value: state.tempo.toDouble(),
              min: 40,
              max: 200,
              onChanged: (value) {
                context.read<MetronomeCubit>().setTempo(value.toInt());
              },
            ),
            ElevatedButton(
              onPressed: () {
                context.read<MetronomeCubit>().toggleMetronome();
              },
              child: Text(state.isRunning ? 'Stop' : 'Start'),
            ),
          ],
        );
      },
    );
  }
}
