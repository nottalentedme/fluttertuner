import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/feature/tuner/cubit/tuner_cubit.dart';
import 'package:fluttertuner/feature/tuner/cubit/tuner_state.dart';
import 'package:fluttertuner/feature/tunings/data/models/tuning_model.dart';
import 'package:fluttertuner/feature/tuner/presentation/widgets/tuner_scale_widgets.dart';
import 'package:fluttertuner/feature/tuner/presentation/widgets/tuner_text_widget.dart';
import 'package:fluttertuner/feature/tuner/presentation/widgets/tuning_mode_switch_widget.dart';

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
                  BlocSelector<TunerCubit, TunerState, double>(
                      selector: (state) => state.note.diffCents,
                      builder: (context, diffState) {
                        return TunerScaleWidgets(value: diffState);
                      }),
                  const SizedBox(height: 20),
                  BlocBuilder<TunerCubit, TunerState>(
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
                                        .read<TunerCubit>()
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
