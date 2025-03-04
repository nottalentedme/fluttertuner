import 'package:go_router/go_router.dart';

import '../../feature/metronome/presentation/page/metronome_page.dart';
import '../../feature/navigation_bar/navigation_bar.dart';
import '../../feature/settings/page/settings_page.dart';
import '../../feature/tuner/presentation/pages/tuner_page.dart';


abstract class AppRouter {
  static final GoRouter router =
      GoRouter(initialLocation: TunerPage.path, routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          NavigationBottomBar(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: MetronomePage.path,
              builder: (context, state) => const MetronomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: TunerPage.path,
              builder: (context, state) => const TunerPage(),
            ),
          ],
        ),
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
  ]);
}
