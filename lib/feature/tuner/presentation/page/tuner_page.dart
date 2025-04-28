import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/feature/tuner/cubit/tuner_cubit.dart';
import 'package:fluttertuner/feature/tuner/cubit/tuner_state.dart';
import 'package:fluttertuner/feature/tuner/presentation/widgets/string_button_widget.dart';
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
          'Tonely',
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
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: GridView.count(
                                crossAxisCount: state.tuning!.notes.length <= 3
                                    ? state.tuning!.notes.length
                                    : 3, // 3 кнопки в ряд максимум
                                shrinkWrap:
                                    true, // чтобы GridView не занимал бесконечную высоту
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: 2.2,

                                physics:
                                    const NeverScrollableScrollPhysics(), // отключить скролл внутри GridView
                                children: List.generate(
                                  state.tuning!.notes.length,
                                  (index) => Container(
                                    alignment: Alignment.center,
                                    child: StringButtonWidget(
                                      isActive:
                                          index == state.currentStringIndex,
                                      onTap: () {
                                        context
                                            .read<TunerCubit>()
                                            .changeString(index);
                                      },
                                      text: state.tuning!.notes[index].name,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(height: 20),
                          ElevatedButton.icon(
                            onPressed: () {
                              context.read<TunerCubit>().toggleTuningMode();
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
