import 'package:flutter/material.dart';
import 'package:fluttertuner/feature/tuner/presentation/widgets/tuner_painter.dart';

class TunerScaleWidget extends StatelessWidget {
  final double value;

  TunerScaleWidget({required this.value});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(300, 150),
      painter: TunerPainter(),
    );
  }
}
