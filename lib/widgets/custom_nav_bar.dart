import 'package:buffer/helper/constants.dart';
import 'package:buffer/linkdin_login.dart';
import 'package:buffer/reddit_login.dart';
import 'package:buffer/screens/secondScreen.dart';
import 'package:buffer/testing_api.dart';
import 'package:flutter/material.dart';
import '../fb_login.dart';
import '../pinteret_login.dart';
import '../screens/check_box_screen.dart';
import '../screens/connect_screen.dart';
import '../screens/home_screen.dart';
import '../screens/post_screen.dart';
import '../screens/profile_screen.dart';
import '../twitter_login.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int currentIndex = 1;
  final screens = [
    const HomeScreen(),
    const ConnectScreen(),
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
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
          child: GNav(
            gap: 6,
            backgroundColor: Colors.black,
            activeColor: Colors.white,
            color: Colors.white,
            selectedIndex: currentIndex,
            tabBackgroundColor: Colors.grey.shade800,
            padding: EdgeInsets.all(9),
            onTabChange: (index) => setState(() => currentIndex = index),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.search,
                text: 'Search',
              ),
              GButton(
                icon: Icons.post_add,
                text: 'Post',
              ),
              GButton(
                icon: Icons.person,
                text: 'Account',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
