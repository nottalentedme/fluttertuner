import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/feature/tuner/cubit/pitch_cubit.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FlutterTune',
          style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
          child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InstrumentTitleWidget(),
              TuningModeSwitchWidget(),
            ],
          ),
          const SizedBox(
            height: 100,
          ),
          Column(
            spacing: 10,
            children: [
              //TODO передавать в value частоту которая сейчас
              //TODO надо как-то передавать частоту
              TunerScaleWidget(value: 0),
              TunerTextWidget(pitchCubitState: pitchCubitState),
              const SizedBox(
                height: 75,
              ),
              Row(
                spacing: 8,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: GuitarString.values
                    .map(
                      (e) => StringButtonWidget(
                          text: e.noteName,
                          onTap: () => setActiveString(e),
                          isActive: e == guitarString),
                    )
                    .toList(),
              ),
            ],
          )
        ],
      )),
    );
  }
}
