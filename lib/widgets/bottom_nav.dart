import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          backgroundColor: Colors.white,
          elevation: 10,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey.shade500,
          selectedFontSize: 15,
          unselectedFontSize: 14,
          iconSize: 28,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(FeatherIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(FeatherIcons.clock),
              label: 'History',
            ),
          ],
        ),
      ),
    );
  }
}
