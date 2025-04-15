import 'package:flutter/material.dart';
import 'package:fluttertuner/core/theme/color_scheme.dart';
import 'package:fluttertuner/feature/tuner/cubit/tuning_state.dart';

class TunerTextWidget extends StatelessWidget {
  const TunerTextWidget({
    super.key,
    required this.pitchCubitState,
  });

  final TuningState pitchCubitState;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                pitchCubitState.targetNote,
                style: const TextStyle(
                  color: AppColorScheme.primary,
                  fontSize: 65.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${pitchCubitState.targetFrequency.toStringAsFixed(1)} Гц',
                style: const TextStyle(
                  color: AppColorScheme.primary,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
