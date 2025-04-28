import 'package:flutter/material.dart';
import 'package:fluttertuner/feature/tunings/presentation/widgets/tuning_selection_widget.dart';

class TuningsPage extends StatelessWidget {
  const TuningsPage({super.key});

  static const path = 'tunings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Строи'), actions: []),
      body: const Center(
        child: TuningSelectionWidget(),
      ),
    );
  }
}
