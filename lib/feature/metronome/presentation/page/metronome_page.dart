import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/core/theme/color_scheme.dart';
import 'package:fluttertuner/core/theme/text_theme.dart';
import 'package:fluttertuner/feature/metronome/cubit/metronome_cubit.dart';
import 'package:fluttertuner/feature/metronome/cubit/metronome_state.dart';
import 'package:fluttertuner/feature/metronome/presentation/widgets/change_bpm_widget.dart';
import 'package:fluttertuner/feature/metronome/presentation/widgets/play_button_widget.dart';
import 'package:fluttertuner/feature/metronome/presentation/widgets/tap_tempo_button_widget.dart';

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
              spacing: 8,
              children: [
                Text(
                  '${state.tempo}',
                  style: AppTextTheme
                      .textTheme.displayLarge, //Прописан только Large
                ),
                Text(
                  'BPM',
                  style: AppTextTheme.textTheme.bodySmall,
                ),
              ],
            ),
            Slider(
              value: state.tempo.toDouble(),
              activeColor: AppColorScheme.primary,
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
                Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChangeBPMWidget(
                      icon: const Icon(
                        Icons.add_rounded,
                        color: AppColorScheme.textwhile,
                      ),
                      onTap: () {
                        context
                            .read<MetronomeCubit>()
                            .setTempo(state.tempo + 1);
                      },
                    ),
                    ChangeBPMWidget(
                      icon: const Icon(
                        Icons.remove_rounded,
                        color: AppColorScheme.textwhile,
                      ),
                      onTap: () {
                        context
                            .read<MetronomeCubit>()
                            .setTempo(state.tempo - 1);
                      },
                    ),
                  ],
                ),
                const Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PlayButtonWidget(),
                    TapTempoButtonWidget(),
                  ],
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
