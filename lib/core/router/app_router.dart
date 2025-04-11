import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/feature/metronome/cubit/metronome_cubit.dart';
import 'package:fluttertuner/feature/tuner/cubit/pitch_cubit.dart';
import 'package:fluttertuner/feature/tuner/service/buffer/buffer_service_impl.dart';
import 'package:fluttertuner/feature/tuner/service/buffer/buffer_service_interface.dart';
import 'package:fluttertuner/feature/tuner/service/recorder/tuner_audio_impl_service.dart';
import 'package:fluttertuner/feature/tuner/service/recorder/tuner_audio_interface_service.dart';
import 'package:go_router/go_router.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'package:pitchupdart/instrument_type.dart';
import 'package:pitchupdart/pitch_handler.dart';

import '../../feature/metronome/presentation/page/metronome_page.dart';
import '../../feature/navigation_bar/navigation_bar.dart';
import '../../feature/settings/page/settings_page.dart';
import '../../feature/tuner/presentation/page/tuner_page.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: TunerPage.path,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return NavigationBottomBar(
            currentIndex: navigationShell.currentIndex,
            onTap: (index) => navigationShell.goBranch(index),
            child: navigationShell,
          );
        },
        branches: [
          // Metronome branch
          StatefulShellBranch(
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
            ],
          ),
          // Tuner branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: TunerPage.path,
                builder: (context, state) {
                  return MultiRepositoryProvider(
                    providers: [
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
                        create: (context) =>
                            PitchHandler(InstrumentType.guitar),
                      ),
                    ],
                    child: MultiBlocProvider(
                      providers: [
                        BlocProvider<PitchCubit>(
                          create: (context) => PitchCubit(
                              context.read<AudioRecorderService>(),
                              context.read<PitchDetector>(),
                              context.read<BufferService>(),
                              context.read<PitchHandler>()),
                        ),
                      ],
                      child: const TunerPage(),
                    ),
                  );
                },
              ),
            ],
          ),
          // Settings branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: SettingsPage.path,
                builder: (context, state) => const SettingsPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
