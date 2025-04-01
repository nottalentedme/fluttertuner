import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/feature/metronome/cubit/metronome_cubit.dart';
import 'package:fluttertuner/feature/metronome/cubit/metronome_state.dart';
import 'package:fluttertuner/feature/metronome/presentation/widgets/change_bpm_widget.dart';
import 'package:fluttertuner/feature/metronome/presentation/widgets/play_button_widget.dart';

class MetronomePage extends StatelessWidget {
  const MetronomePage({super.key});

  static const path = '/metronome';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MetronomeCubit, MetronomeState>(
      builder: (context, state) {
        return Column(
          children: [
            const SizedBox(
              height: 400,
            ),
            Column(
              children: [
                Text(
                  '${state.tempo}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 42,
                  ),
                ),
                const Text(
                  'BPM',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Slider(
              value: state.tempo.toDouble(),
              activeColor: Colors.black,
              min: 40,
              max: 200,
              onChanged: (value) {
                context.read<MetronomeCubit>().setTempo(value.toInt());
              },
            ),
            Row(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChangeBPMWidget(
                  icon: const Icon(
                    Icons.remove_rounded,
                    color: Colors.white,
                  ),
                  onTap: () {
                    context.read<MetronomeCubit>().setTempo(state.tempo - 1);
                  },
                ),
                const PlayButtonWidget(),
                ChangeBPMWidget(
                  icon: const Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                  ),
                  onTap: () {
                    context.read<MetronomeCubit>().setTempo(state.tempo + 1);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            //TAP button
            InkWell(
              customBorder: const CircleBorder(),
              onTap: () => context.read<MetronomeCubit>().registerTap(),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                  border: Border.all(
                    width: 2,
                    color: Colors.black,
                  ),
                ),
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  'Tap',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        );
      },
    );
  }

//хз зачем отдельное окно под тап темпо
  void _showTapTempoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Tap Tempo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Тут будет бпм'),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  context.read<MetronomeCubit>().registerTap();
                },
                child: const Text('Тык'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Закрыть'),
            ),
          ],
        );
      },
    );
  }
}
