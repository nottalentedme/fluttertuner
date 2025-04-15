import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertuner/feature/tuner/presentation/widgets/tuner_painter.dart';

class TunerScaleWidgets extends StatelessWidget {
  final double value;

  const TunerScaleWidgets({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 150,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Шкала (без стрелки)
          CustomPaint(
            size: const Size(300, 150),
            painter: TunerPainter(),
          ),

          // Стрелка (с возможностью регулировать угол и позицию)
          Transform.translate(
            offset: const Offset(0, -10), // Регулируй расстояние по Y
            child: Transform.rotate(
              angle: (value / 60) * pi, // Угол поворота
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'assets/tuner/strelka.png',
                height: 90, // Настрой размеры под своё изображение
              ),
            ),
          ),
        ],
      ),
    );
  }
}
