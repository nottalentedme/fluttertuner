import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertuner/feature/tuner/presentation/widgets/tuner_scale_widget.dart';

class TunerScale extends StatefulWidget {
  @override
  _TunerScreenState createState() => _TunerScreenState();
}

class _TunerScreenState extends State<TunerScale>
    with SingleTickerProviderStateMixin {
  double value = 0.0;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: value).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  void updateValue(double newValue) {
    setState(() {
      value = newValue;
      _animation = Tween<double>(begin: _animation.value, end: value)
          .animate(_controller);
      _controller.forward(from: 0.0);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Тюнер')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TunerScaleWidget(
              value: _animation.value,
            ),
            SizedBox(height: 20),
            Slider(
              value: value,
              min: -60,
              max: 60,
              onChanged: (newValue) {
                updateValue(newValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}
