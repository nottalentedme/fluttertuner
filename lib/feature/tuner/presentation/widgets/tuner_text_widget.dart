import 'package:flutter/material.dart';
import 'package:fluttertuner/core/theme/color_scheme.dart';
import 'package:fluttertuner/feature/tuner/cubit/tunning_state.dart';

class TunerTextWidget extends StatelessWidget {
  const TunerTextWidget({
    super.key,
    required this.pitchCubitState,
  });

  final TunningState pitchCubitState;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                pitchCubitState.note,
                style: const TextStyle(
                  color: AppColorScheme.primary,
                  fontSize: 65.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${pitchCubitState.frequency.toStringAsFixed(1)} Гц',
                style: const TextStyle(
                  color: AppColorScheme.primary,
                  fontSize: 24.0,
                ),
              ),
            ],
          ),
          Text(
            pitchCubitState.status,
            style: const TextStyle(
              color: AppColorScheme.primary,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }
}
