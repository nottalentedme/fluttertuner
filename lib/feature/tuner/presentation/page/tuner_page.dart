import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/feature/tuner/cubit/pitch_cubit.dart';
import 'package:fluttertuner/feature/tuner/cubit/tuning_state.dart';
import 'package:fluttertuner/feature/tuner/domain/ChangeString/change_string.dart';
import 'package:fluttertuner/feature/tuner/presentation/widgets/instrument_title_widget.dart';
import 'package:fluttertuner/feature/tuner/presentation/widgets/string_button_widget.dart';
import 'package:fluttertuner/feature/tuner/presentation/widgets/tuner_scale_widget.dart';
import 'package:fluttertuner/feature/tuner/presentation/widgets/tuner_text_widget.dart';
import 'package:fluttertuner/feature/tuner/presentation/widgets/tuning_mode_switch_widget.dart';

class TunerPage extends StatefulWidget {
  const TunerPage({super.key});

  static const path = '/tuner';

  @override
  State<TunerPage> createState() => _TunerPageState();
}

class _TunerPageState extends State<TunerPage> {
  GuitarString guitarString = GuitarString.sixthE;

  void setActiveString(GuitarString value) {
    setState(() {
      guitarString = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pitchCubitState = context.watch<PitchCubit>().state;

    return BlocBuilder<PitchCubit, TuningState>(builder: (context, state) {
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
                  InstrumentTitleWidget(),
                  TuningModeSwitchWidget(),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TunerScaleWidget(value: 0),
                    const SizedBox(height: 20),
                    TunerTextWidget(pitchCubitState: pitchCubitState),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: GuitarString.values
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: StringButtonWidget(
                            text: e.noteName,
                            onTap: () => setActiveString(e),
                            isActive: e == guitarString,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
