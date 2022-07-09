import 'package:buffer/helper/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/home_card_list.dart';
import '../widgets/home_stories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: new Color(0xfff8faf8),
        centerTitle: true,
        elevation: 0,
        leading: const Icon(
          Icons.camera_alt,
          color: whiteColor,
        ),
        title: SizedBox(
            height: 40.0,
            child: Image.asset(
              "assets/insta_logo.png",
              color: whiteColor,
            )),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: IconButton(
              icon: Icon(Icons.send),
              color: whiteColor,
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            color: Colors.black12,
            height: MediaQuery.of(context).size.height * 0.19,
            child: const HomeStories(),
          ),
          const HomeCardList(),
        ],
      ),
    );
  }
}
