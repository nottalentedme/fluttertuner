import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertuner/feature/metronome/presentation/page/metronome_page.dart';
import 'package:fluttertuner/feature/settings/page/settings_page.dart';
import 'package:fluttertuner/feature/tuner/presentation/page/tuner_page.dart';
import 'package:go_router/go_router.dart';

class NavigationBottomBar extends StatelessWidget {
  const NavigationBottomBar({
    super.key,
    required this.currentIndex,
    required this.child,
  });

  final int currentIndex;
  final Widget child;

  static const path = '/navigation';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        enableFeedback: false,
        selectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/metronome.svg'),
            label: 'Метроном',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 24,
              height: 24,
              child: SvgPicture.asset('assets/icons/tuner.svg'),
            ),
            label: 'Тюнер',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/settings.svg'),
            label: 'Настройки',
          ),
        ],
        currentIndex: currentIndex,
        onTap: (index) => _onItemTapped(context, index),
      ),
    );
  }

  void _onItemTapped(BuildContext context, int index) {
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
  }
}
