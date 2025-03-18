import 'package:flutter/material.dart';

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
          Text(
            'Авто',
            style: TextStyle(
                fontSize: 30,
                fontWeight:
                    FontWeight.lerp(FontWeight.w700, FontWeight.w500, 0.5)),
          ),
          const SizedBox(
            width: 10,
          ),
          //TODO подключить свитч к смене режима авто/ручной
          Switch(
            value: isActive,
            onChanged: toggleSwitch,
            activeTrackColor: Colors.black,
          )
        ],
      ),
    );
  }
}
