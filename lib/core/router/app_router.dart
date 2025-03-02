import 'package:fluttertuner/feature/metronome/presentation/page/metronome_page.dart';
import 'package:fluttertuner/feature/settings/page/settings_page.dart';
import 'package:fluttertuner/feature/tuner/presentation/page/tuner_page.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/home_screen',
    routes : [
      GoRoute(
        path: SettingsPage.path,
        builder: (context, state) => const SettingsPage()
      ),
      GoRoute(
        path: MetronomePage.path,
        builder: (context, state) => const MetronomePage()
      ),
      GoRoute(
        path: TunerPage.path,
        builder: (context, state) => const TunerPage()
      ),
    ]
  );
}