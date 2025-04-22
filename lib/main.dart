import 'package:flutter/material.dart';
import 'package:fluttertuner/core/theme/app_theme.dart';
import 'package:fluttertuner/feature/config/config.dart';
import 'core/router/app_router.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      theme: AppTheme.theme,
    );
  }
}
