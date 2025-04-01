import 'package:flutter/material.dart';
import 'package:fluttertuner/core/theme/color_scheme.dart';

class TuningModeSwitchWidget extends StatefulWidget {
  const TuningModeSwitchWidget({
    super.key,
  });

  @override
  State<TuningModeSwitchWidget> createState() => _TuningModeSwitchWidgetState();
}

class _TuningModeSwitchWidgetState extends State<TuningModeSwitchWidget> {
  bool isActive = true;

  void toggleSwitch(bool value) {
    if (isActive == false) {
      setState(() {
        isActive = true;
      });
    } else {
      setState(() {
        isActive = false;
      });
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Text(
            'Авто',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: AppColorScheme.primary),
          ),
          const SizedBox(
            width: 10,
          ),
          //TODO подключить свитч к смене режима авто/ручной
          Switch(
            value: isActive,
            onChanged: toggleSwitch,
            activeTrackColor: AppColorScheme.primary,
          )
        ],
      ),
    );
  }
}
