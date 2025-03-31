import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/feature/metronome/cubit/metronome_cubit.dart';
import 'package:fluttertuner/feature/tuner/cubit/pitch_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'package:pitchupdart/instrument_type.dart';
import 'package:pitchupdart/pitch_handler.dart';
import 'package:record/record.dart';

import '../../feature/metronome/presentation/page/metronome_page.dart';
import '../../feature/navigation_bar/navigation_bar.dart';
import '../../feature/settings/page/settings_page.dart';
import '../../feature/tuner/presentation/page/tuner_page.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: TunerPage.path,
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          // Получаем текущий индекс на основе текущего пути
          int currentIndex = 1; // По умолчанию тюнер
          if (state.uri.path == MetronomePage.path) {
            currentIndex = 0;
          } else if (state.uri.path == SettingsPage.path) {
            currentIndex = 2;
          }

          return NavigationBottomBar(
            currentIndex: currentIndex,
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: MetronomePage.path,
            builder: (context, state) {
              return BlocProvider<MetronomeCubit>(
                create: (context) => MetronomeCubit(),
                child: const MetronomePage(),
              );
            },
          ),
          GoRoute(
            path: TunerPage.path,
            builder: (context, state) {
              return MultiRepositoryProvider(
                providers: [
                  RepositoryProvider<AudioRecorder>(
                    create: (context) => AudioRecorder(),
                  ),
                  RepositoryProvider<PitchDetector>(
                    create: (context) => PitchDetector(),
                  ),
                  RepositoryProvider<PitchHandler>(
                    create: (context) => PitchHandler(InstrumentType.guitar),
                  ),
                ],
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider<PitchCubit>(
                      create: (context) => PitchCubit(
                        context.read<AudioRecorder>(),
                        context.read<PitchDetector>(),
                        context.read<PitchHandler>(),
                      ),
                    ),
                  ],
                  child: const TunerPage(),
                ),
              );
            },
          ),
          GoRoute(
            path: SettingsPage.path,
            builder: (context, state) => const SettingsPage(),
          ),
        ],
      ),
    ],
  );
}
