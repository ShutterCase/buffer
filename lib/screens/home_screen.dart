import 'package:buffer/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/home_body.dart';

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
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(
              Icons.send,
              color: whiteColor,
            ),
          )
        ],
      ),
      body: HomeBody(),
    );
  }
}
