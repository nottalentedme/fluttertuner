import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/feature/tuner/cubit/tuning_cubit.dart';
import 'package:fluttertuner/feature/tuner/cubit/tuning_state.dart';
import 'package:fluttertuner/feature/tuner/presentation/widgets/pos.dart';
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
                  BlocSelector<TuningCubit, TuningState, double>(
                      selector: (state) => state.note.diffCents,
                      builder: (context, diffState) {
                        return TunerScaleWidgets(value: diffState);
                      }),
                  const SizedBox(height: 20),
                  BlocBuilder<TuningCubit, TuningState>(
                      builder: (context, state) {
                    return TunerTextWidget(note: state.note);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
