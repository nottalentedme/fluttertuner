import 'dart:ui' as ui;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertuner/core/theme/color_scheme.dart';

class TunerPainter extends CustomPainter {
  static ui.Image? _shtrixImage;
  static bool _loading = false;

  TunerPainter() {
    _loadImage();
  }

  void _loadImage() async {
    if (_shtrixImage != null || _loading) return;
    _loading = true;
    final byteData = await rootBundle.load('assets/tuner/shtrix.png');
    final codec = await ui.instantiateImageCodec(byteData.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    _shtrixImage = frame.image;
    _loading = false;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;

    // Отрисовка шкалы (shtrix.png)
    if (_shtrixImage != null) {
      final imageHeight = size.height * 0.9;
      final imageTop = size.height - imageHeight - 12; // поднята чуть выше

      final targetRect = Rect.fromLTWH(
        -2, //Влево вправо Шкалу перемещать
        imageTop,
        size.width,
        imageHeight,
      );

      canvas.drawImageRect(
        _shtrixImage!,
        Rect.fromLTWH(0, 0, _shtrixImage!.width.toDouble(),
            _shtrixImage!.height.toDouble()),
        targetRect,
        Paint(),
      );
    }

    // Подписи (-60, -40, ..., 60) — как в твоей изначальной реализации
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    for (int i = -60; i <= 60; i += 20) {
      final angle = (i / 41 + 3 * pi / 2); // тот самый формат
      final x = center.dx + 1.15 * radius * cos(angle);
      final y = center.dy + 1.15 * radius * sin(angle);

      textPainter.text = TextSpan(
        text: '$i',
        style: const TextStyle(
          color: AppColorScheme.primary,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, y - textPainter.height / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
