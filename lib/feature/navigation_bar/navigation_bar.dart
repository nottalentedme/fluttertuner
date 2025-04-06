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
        onTap: onTap,
      ),
    );
  }
}
