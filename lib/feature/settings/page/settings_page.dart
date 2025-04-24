import 'package:flutter/material.dart';
import 'package:fluttertuner/feature/tuner/presentation/widgets/tuning_selection_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const path = '/settings';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: TuningSelector()),
    );
  }
}
