import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/feature/metronome/cubit/metronome_cubit.dart';

class TapTempoButtonWidget extends StatelessWidget {
  const TapTempoButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: () => context.read<MetronomeCubit>().registerTap(),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: theme.primary,
          border: Border.all(
            width: 2,
            color: theme.primary,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Tap',
          style: TextStyle(
            color: theme.surface,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
