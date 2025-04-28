import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/feature/metronome/cubit/metronome_cubit.dart';
import 'package:fluttertuner/feature/metronome/cubit/metronome_state.dart';
import 'package:fluttertuner/feature/metronome/presentation/widgets/change_bpm_widget.dart';
import 'package:fluttertuner/feature/metronome/presentation/widgets/play_button_widget.dart';
import 'package:fluttertuner/feature/metronome/presentation/widgets/tap_tempo_button_widget.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class MetronomePage extends StatelessWidget {
  const MetronomePage({super.key});

  static const path = '/metronome';
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return BlocBuilder<MetronomeCubit, MetronomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: theme.primary,
            title: const Text(
              'Tonely',
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            ),
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              // Column(
              //   spacing: 8,
              //   children: [
              //     Text(
              //       '${state.tempo}',
              //       style: TextStyle(
              //         color: theme.primary,
              //         fontSize: 42,
              //       ), //Прописан только Large
              //     ),
              //     Text(
              //       'BPM',
              //       style: TextStyle(
              //         color: theme.primary.withAlpha(100),
              //         fontSize: 14,
              //       ),
              //     ),
              //   ],
              // ),
              SleekCircularSlider(
                appearance: CircularSliderAppearance(
                    animationEnabled: false,
                    size: 300,
                    customWidths: CustomSliderWidths(
                      trackWidth: 5,
                      progressBarWidth: 10,
                      handlerSize: 10,
                    ),
                    customColors: CustomSliderColors(
                      trackColor: theme.primary.withAlpha(200),
                      progressBarColor: theme.secondary,
                      dotColor: theme.onPrimary,
                    )),
                initialValue: state.tempo.toDouble(),
                // activeColor: theme.primary,
                innerWidget: (percentage) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 8,
                  children: [
                    Text(
                      '${state.tempo}',
                      style: TextStyle(
                        color: theme.onPrimary,
                        fontSize: 60,
                      ), //Прописан только Large
                    ),
                    Text(
                      'BPM',
                      style: TextStyle(
                        color: theme.onPrimary.withAlpha(100),
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                min: 40,
                max: 200,
                onChange: (value) {
                  context.read<MetronomeCubit>().setTempo(value.toInt());
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Transform.scale(
                  scale: 1.2,
                  child: Row(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ChangeBPMWidget(
                        icon: Icon(
                          Icons.add_rounded,
                          color: theme.secondary,
                        ),
                        onTap: () {
                          context
                              .read<MetronomeCubit>()
                              .setTempo(state.tempo + 1);
                        },
                      ),
                      ChangeBPMWidget(
                        icon: Icon(
                          Icons.remove_rounded,
                          color: theme.secondary,
                        ),
                        onTap: () {
                          context
                              .read<MetronomeCubit>()
                              .setTempo(state.tempo - 1);
                        },
                      ),
                      const PlayButtonWidget(),
                      const TapTempoButtonWidget()
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
