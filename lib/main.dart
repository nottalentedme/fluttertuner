import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/core/theme/app_theme.dart';
import 'package:fluttertuner/feature/tuner/cubit/pitch_cubit.dart';
import 'package:fluttertuner/feature/tuner/domain/repository/tuning_repository_impl.dart';
import 'package:fluttertuner/feature/tuner/service/buffer/buffer_service_impl.dart';
import 'package:fluttertuner/feature/tuner/service/buffer/buffer_service_interface.dart';
import 'package:fluttertuner/feature/tuner/service/recorder/tuner_audio_impl_service.dart';
import 'package:fluttertuner/feature/tuner/service/recorder/tuner_audio_interface_service.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'package:pitchupdart/instrument_type.dart';
import 'package:pitchupdart/pitch_handler.dart';
import 'core/router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<TuningRepository>(
          create: (context) => TuningRepositoryImpl(
            AudioRecorderServiceImpl(),
            BufferServiceImpl(),
            PitchDetector(),
            PitchHandler(InstrumentType.guitar),
          ),
        ),
        RepositoryProvider<AudioRecorderService>(
          create: (context) => AudioRecorderServiceImpl(),
        ),
        RepositoryProvider<PitchDetector>(
          create: (context) => PitchDetector(),
        ),
        RepositoryProvider<BufferService>(
          create: (context) => BufferServiceImpl(),
        ),
        RepositoryProvider<PitchHandler>(
          create: (context) => PitchHandler(InstrumentType.guitar),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<PitchCubit>(
            create: (context) => PitchCubit(
              context.read<TuningRepository>(),
            ),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: AppRouter.router,
          theme: ThemeData.light(),
        ),
      ),
    );
  }
}
