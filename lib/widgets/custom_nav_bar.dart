import 'package:buffer/constants.dart';
import 'package:buffer/screens/secondScreen.dart';
import 'package:flutter/material.dart';

import '../screens/home_screen.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int currentIndex = 1;
  final screens = [
    const HomeScreen(),
    const SecondScreen(),
    // NewsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          selectedItemColor: whiteColor,
          iconSize: 24,
          selectedFontSize: 12,
          unselectedFontSize: 14,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.grey,
          onTap: (index) => setState(() => currentIndex = index),
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(Icons.person),
            ),
            // BottomNavigationBarItem(
            //   label: 'News',
            //   icon: Icon(Icons.newspaper),
            // )
          ],
        ),
      ),
    );
  }
}
