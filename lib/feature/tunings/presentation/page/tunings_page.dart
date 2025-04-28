import 'package:flutter/material.dart';
import 'package:fluttertuner/feature/tunings/presentation/widgets/tuning_selection_widget.dart';

class TuningsPage extends StatelessWidget {
  const TuningsPage({super.key});

  static const path = 'tunings';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Строи',
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: theme.primary,
      ),
      body: const Center(
        child: TuningSelectionWidget(),
      ),
    );
  }
}
