import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavigationBottomBar extends StatelessWidget {
  const NavigationBottomBar({
    super.key,
    required this.currentIndex,
    required this.child,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final Widget child;

  static const path = '/navigation';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: theme.tertiary,
        type: BottomNavigationBarType.shifting,
        enableFeedback: false,
        selectedItemColor: theme.onPrimary,
        items: [
          BottomNavigationBarItem(
            backgroundColor: theme.primary,
            icon: SvgPicture.asset(
              'assets/icons/metronome.svg',
              color: theme.secondary,
            ),
            label: 'Metronome',
          ),
          BottomNavigationBarItem(
            backgroundColor: theme.primary,
            icon: SizedBox(
              width: 24,
              height: 24,
              child: SvgPicture.asset(
                'assets/icons/tuner.svg',
                color: theme.secondary,
              ),
            ),
            label: 'Tuner',
          ),
          BottomNavigationBarItem(
            backgroundColor: theme.primary,
            icon: SvgPicture.asset(
              'assets/icons/settings.svg',
              color: theme.secondary,
            ),
            label: 'Settings',
          ),
        ],
        currentIndex: currentIndex,
        onTap: onTap,
      ),
    );
  }
}
