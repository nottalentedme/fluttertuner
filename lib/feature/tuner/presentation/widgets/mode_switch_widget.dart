import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/feature/tuner/cubit/tuner_cubit.dart';
import 'package:fluttertuner/feature/tuner/cubit/tuner_state.dart';
import 'package:fluttertuner/feature/tunings/data/models/tuning_model.dart';

class ModeSwitcher extends StatelessWidget {
  final TuningMode mode;

  const ModeSwitcher({
    super.key,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return BlocBuilder<TunerCubit, TunerState>(builder: (context, state) {
      return GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity != 0) {
            context.read<TunerCubit>().toggleTuningMode();
          }
        },
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: child,
          ),
          child: Text(
            _modeToString(mode),
            key: ValueKey(mode),
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: theme.onPrimary),
          ),
        ),
      );
    });
  }

  String _modeToString(TuningMode mode) {
    switch (mode) {
      case TuningMode.chromatic:
        return 'Chromatic';
      case TuningMode.scale:
        return 'Scale';
    }
  }
}
