import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/feature/tuner/cubit/tuner_cubit.dart';
import 'package:fluttertuner/feature/tuner/cubit/tuner_state.dart';
import 'package:fluttertuner/feature/tuner/presentation/widgets/mode_switch_widget.dart';
import 'package:fluttertuner/feature/tuner/presentation/widgets/string_button_widget.dart';
import 'package:fluttertuner/feature/tunings/data/models/tuning_model.dart';
import 'package:fluttertuner/feature/tuner/presentation/widgets/tuner_scale_widgets.dart';
import 'package:fluttertuner/feature/tuner/presentation/widgets/tuner_text_widget.dart';

class TunerPage extends StatelessWidget {
  const TunerPage({super.key});

  static const path = '/tuner';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: theme.primary,
          title: const Text('Tonely',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ))),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 10),
            Center(
                child: Column(
              children: [
                ModeSwitcher(mode: context.watch<TunerCubit>().state.mode),
                const Text(
                  'Swipe to change mode',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            )),
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
                          const SizedBox(height: 10),
                          AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            reverseDuration: const Duration(milliseconds: 300),
                            child: state.mode == TuningMode.scale
                                ? Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: GridView.count(
                                      crossAxisCount:
                                          state.tuning!.notes.length <= 3
                                              ? state.tuning!.notes.length
                                              : 3,
                                      shrinkWrap: true,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8,
                                      childAspectRatio: 2.0,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      children: List.generate(
                                        state.tuning!.notes.length,
                                        (index) => Container(
                                          alignment: Alignment.center,
                                          child: StringButtonWidget(
                                            isActive: index ==
                                                state.currentStringIndex,
                                            onTap: () {
                                              context
                                                  .read<TunerCubit>()
                                                  .changeString(index);
                                            },
                                            text:
                                                state.tuning!.notes[index].name,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(
                                    height:
                                        120), // Пустое место, когда нет кнопок
                          ),
                          const SizedBox(height: 10),
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
