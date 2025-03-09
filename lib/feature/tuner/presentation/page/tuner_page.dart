import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/feature/tuner/cubit/pitch_cubit.dart';

class TunerPage extends StatelessWidget {
  const TunerPage({super.key});


  static const path = '/tuner';

  
  @override
  Widget build(BuildContext context) {
    final pitchCubitState = context.watch<PitchCubit>().state;
    
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              pitchCubitState.note,
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 65.0,
                  fontWeight: FontWeight.bold
              ),
            ),
            Text(
             pitchCubitState.status,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 18.0,
              ),
            ),
        ]),
      ),
    );
  }
}