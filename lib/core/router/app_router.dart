import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/core/extension/build_context_extension.dart';
import 'package:fluttertuner/feature/metronome/cubit/metronome_cubit.dart';
import 'package:fluttertuner/feature/metronome/services/metronome_player.dart';
import 'package:fluttertuner/feature/tuner/cubit/pitch_cubit.dart';
import 'package:fluttertuner/feature/tuner/domain/repository/interface/tuning_repository.dart';
import 'package:go_router/go_router.dart';

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
                    create: (context) =>
                        MetronomeCubit(context.dep<MetronomePlayer>()),
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
                  return BlocProvider(
                    create: (context) =>
                        PitchCubit(context.dep<TuningRepository>()),
                    child: const TunerPage(),
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
