import 'package:flutter/material.dart';
import 'package:fluttertuner/feature/tuner/cubit/tunning_state.dart';

class TunerTextWidget extends StatelessWidget {
  const TunerTextWidget({
    super.key,
    required this.pitchCubitState,
  });

  final TunningState pitchCubitState;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            pitchCubitState.note,
            style: const TextStyle(
                color: Colors.black87,
                fontSize: 65.0,
                fontWeight: FontWeight.bold),
          ),
          Text(
            pitchCubitState.status,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }
}
