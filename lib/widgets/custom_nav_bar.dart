import 'package:buffer/helper/constants.dart';
import 'package:buffer/screens/secondScreen.dart';
import 'package:flutter/material.dart';
import '../screens/check_box_screen.dart';
import '../screens/home_screen.dart';
import '../screens/post_screen.dart';
import '../screens/profile_screen.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int currentIndex = 3;
  final screens = [
    const HomeScreen(),
    const SecondScreen(),
    const PostScreen(),
    const ProfileScreen(),
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
              label: 'gallery',
              icon: Icon(Icons.browse_gallery),
            ),
            BottomNavigationBarItem(
              label: 'checkbox',
              icon: Icon(Icons.align_horizontal_right),
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
