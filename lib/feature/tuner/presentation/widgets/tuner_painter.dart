import 'dart:math';
import 'package:flutter/material.dart';

class TunerPainter extends CustomPainter {
  final double value;

  TunerPainter({required this.value});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;

    // Отрисовка шкалы
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.14, // Начальный угол
      3.14, // Конечный угол
      false,
      paint,
    );

    // Отрисовка делений и текста
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    for (int i = -60; i <= 60; i += 20) {
      final angle = (i / 40 + 3 * 3.14 / 2);
      final x = center.dx + 1.15 * radius * cos(angle);
      final y = center.dy + 1.15 * radius * sin(angle);

      if (i % 20 == 0) {
        textPainter.text = TextSpan(
            text: '$i',
            style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold));
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(x - textPainter.width / 2, y - textPainter.height / 2),
        );
      }
    }

    //TODO установить стрелку вертикально вверх
    // Отрисовка стрелки
    final arrowPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final arrowAngle = (value / 60) * 3.14;
    final path = Path();
    path.moveTo(center.dx, center.dy);
    path.lineTo(
      center.dx + radius * cos(arrowAngle),
      center.dy + radius * sin(arrowAngle),
    );
    path.lineTo(
      center.dx + 10 * cos(arrowAngle - 3.14 / 2),
      center.dy + 10 * sin(arrowAngle - 3.14 / 2),
    );
    path.close();

    canvas.drawPath(path, arrowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
