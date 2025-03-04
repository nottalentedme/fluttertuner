import 'package:convex_bottom_bar/convex_bottom_bar.dart';
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
      bottomNavigationBar: ConvexAppBar(
        items: [
          //TODO надо порешать что-то с изменением размера svg иконки
          TabItem(icon: SvgPicture.asset('assets/icons/metronome.svg'), title: 'Метроном'),
          TabItem(icon: SvgPicture.asset('assets/icons/tuner.svg'), title: 'Тюнер'),
          const TabItem(
              icon: Icon(Icons.settings), title: 'Настройки'),
        ],
        initialActiveIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(index),
      ),
    );
  }
}
