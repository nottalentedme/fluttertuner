import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/core/extension/build_context_extension.dart';
import 'package:fluttertuner/core/theme/app_theme.dart';
import 'package:fluttertuner/core/theme/cubit/theme_cubit.dart';
import 'package:fluttertuner/core/theme/cubit/theme_state.dart';
import 'package:fluttertuner/feature/config/config.dart';
import 'package:fluttertuner/feature/settings/repository/theme_repository_interface.dart';
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
    return BlocProvider(
      create: (context) =>
          ThemeCubit(themeRepository: context.dep<ThemeRepository>()),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            routerConfig: AppRouter.router,
            theme: state.isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
          );
        },
      ),
    );
  }
}
