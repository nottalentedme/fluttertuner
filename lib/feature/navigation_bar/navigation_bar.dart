import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class NavigationBottomBar extends StatelessWidget {
  const NavigationBottomBar({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  static const path = '/navigation';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        enableFeedback: false,
        selectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/metronome.svg'),
              label: 'Метроном'),
          
          BottomNavigationBarItem(
            icon: SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset('assets/icons/tuner.svg')),
            label: 'Тюнер',
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/settings.svg'), label: 'Настройки'),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(index),
      ),
    );
  }
}
