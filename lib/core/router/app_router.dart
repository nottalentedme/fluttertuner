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
      ShellRoute(
        builder: (context, state, child) {
          final path = state.uri.path;
          final index = _getIndexFromPath(path);

          return NavigationBottomBar(
            currentIndex: index,
            onTap: (index) {
              switch (index) {
                case 0:
                  context.go(MetronomePage.path);
                  break;
                case 1:
                  context.go(TunerPage.path);
                  break;
                case 2:
                  context.go(SettingsPage.path);
                  break;
              }
            },
            child: child,
          );
        },
        routes: [
          // Metronome branch
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
          // Tuner branch
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
          // Settings branch
          GoRoute(
            path: SettingsPage.path,
            builder: (context, state) => const SettingsPage(),
          ),
        ],
      ),
    ],
  );

  static int _getIndexFromPath(String path) {
    switch (path) {
      case MetronomePage.path:
        return 0;
      case TunerPage.path:
        return 1;
      case SettingsPage.path:
        return 2;
      default:
        return 1;
    }
  }
}
