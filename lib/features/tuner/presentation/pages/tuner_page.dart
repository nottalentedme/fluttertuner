import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuner/features/tuner/data/repositories/tuner_repository.dart';
import 'package:tuner/features/tuner/presentation/bloc/tuner_bloc.dart';
import 'package:tuner/features/tuner/presentation/bloc/tuner_event.dart';
import 'package:tuner/features/tuner/presentation/bloc/tuner_state.dart';
import 'package:tuner/features/tuner/presentation/widgets/note_display.dart';

class TunerPage extends StatelessWidget {
  const TunerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TunerBloc(
        context.read<TunerRepository>(),
      ),
      child: const TunerView(),
    );
  }
}

class TunerView extends StatelessWidget {
  const TunerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Гитарный тюнер'),
      ),
      body: Center(
        child: BlocConsumer<TunerBloc, TunerState>(
          listener: (context, state) {
            if (state is TunerError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state is TunerActive) NoteDisplay(note: state.note),
                if (state is TunerLoading)
                  const CircularProgressIndicator(),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (state is! TunerActive) {
                      context.read<TunerBloc>().add(const StartTuning());
                    } else {
                      context.read<TunerBloc>().add(const StopTuning());
                    }
                  },
                  child: Text(
                    state is TunerActive ? 'Остановить' : 'Начать',
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
} 