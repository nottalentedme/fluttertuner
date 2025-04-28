import 'dart:math';

import 'package:flutter/material.dart';

class TunerScaleWidgets extends StatefulWidget {
  final double value;

  const TunerScaleWidgets({super.key, required this.value});

  @override
  State<TunerScaleWidgets> createState() => _TunerScaleWidgetsState();
}

class _TunerScaleWidgetsState extends State<TunerScaleWidgets> {
  double _previousValue = 0;

  double checkValue(double value) {
    if (value >= 60) {
      value = 60;
    } else if (value <= -60) {
      value = -60;
    }
    return value;
  }

  @override
  void didUpdateWidget(covariant TunerScaleWidgets oldWidget) {
    super.didUpdateWidget(oldWidget);
    _previousValue = oldWidget.value; // сохраняем "откуда" анимировать
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return SizedBox(
      width: 300,
      height: 150,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Transform.scale(
            scale: 1.3,
            child: Image.asset(
              'assets/tuner/scale.png',
              color: theme.secondary,
            ),
          ),
          Transform.scale(
            scale: 1.3,
            child: Transform.translate(
              offset: const Offset(2, -5),
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(
                    begin: _previousValue, end: checkValue(widget.value)),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut,
                builder: (context, animatedValue, child) {
                  return Transform.rotate(
                    angle: (animatedValue / 120) * pi,
                    alignment: Alignment.bottomCenter,
                    child: child,
                  );
                },
                child: Image.asset(
                  'assets/tuner/strelka.png',
                  height: 90,
                  color: theme.secondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
