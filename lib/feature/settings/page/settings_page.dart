import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/core/theme/cubit/theme_cubit.dart';
import 'package:fluttertuner/feature/tunings/presentation/page/tunings_page.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const path = '/settings';
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(children: [
          Card(
            child: ListTile(
              title: Text('Тёмная тема'),
              trailing: Switch(
                  activeColor: theme.onPrimary,
                  value: Theme.of(context).brightness == Brightness.dark,
                  onChanged: (_) {
                    context.read<ThemeCubit>().toggleTheme();
                  }),
            ),
          ),
          Card(
            child: ListTile(
              trailing: const Icon(Icons.arrow_forward),
              title: Text('Строи'),
              onTap: () => context.go('/settings/${TuningsPage.path}'),
            ),
          ),

          // TuningSelectionWidget(),
        ]),
      ),
    );
  }
}
