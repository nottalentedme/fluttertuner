import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/feature/tuner/cubit/tuning_cubit.dart';
import 'package:fluttertuner/feature/tuner/cubit/tuning_state.dart';
import 'package:fluttertuner/feature/tuner/data/models/tuning_model.dart';
import 'package:fluttertuner/feature/tuner/presentation/widgets/instrument_title_widget.dart';
import 'package:fluttertuner/feature/tuner/presentation/widgets/pos.dart';
import 'package:fluttertuner/feature/tuner/presentation/widgets/tuner_text_widget.dart';
import 'package:fluttertuner/feature/tuner/presentation/widgets/tuning_mode_switch_widget.dart';
import 'package:fluttertuner/feature/tuner/presentation/widgets/tuning_selection_widget.dart';
import 'package:fluttertuner/feature/tuner/service/recorder/tuner_audio_impl_service.dart';

class TunerPage extends StatelessWidget {
  const TunerPage({super.key});

  static const path = '/tuner';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FlutterTune',
          style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TuningModeSwitchWidget(),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocSelector<TuningCubit, TuningState, double>(
                      selector: (state) => state.note.diffCents,
                      builder: (context, diffState) {
                        return TunerScaleWidgets(value: diffState);
                      }),
                  const SizedBox(height: 20),
                  BlocBuilder<TuningCubit, TuningState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          TunerTextWidget(note: state.note),
                          const SizedBox(height: 20),
                          if (state.mode == TuningMode.scale)
                            Wrap(
                              spacing: 8,
                              alignment: WrapAlignment.center,
                              children: List.generate(
                                state.tuning!.notes.length,
                                (index) => ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        index == state.currentStringIndex
                                            ? Colors.blueAccent
                                            : Colors.grey[700],
                                  ),
                                  onPressed: () {
                                    context
                                        .read<PitchCubit>()
                                        .changeString(index);
                                  },
                                  child: Text(
                                    state.tuning!.notes[index].name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(height: 20),
                          ElevatedButton.icon(
                            onPressed: () {
                              context.read<PitchCubit>().toggleTuningMode();
                            },
                            icon: const Icon(Icons.swap_horiz),
                            label: Text(
                              state.mode == TuningMode.scale
                                  ? 'Switch to Chromatic'
                                  : 'Switch to Scale',
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
