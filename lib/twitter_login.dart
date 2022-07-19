import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twitter_login/twitter_login.dart';

class TwitterLoginTest extends StatefulWidget {
  const TwitterLoginTest({Key? key}) : super(key: key);

  @override
  State<TwitterLoginTest> createState() => _TwitterLoginTestState();
}

class _TwitterLoginTestState extends State<TwitterLoginTest> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Twitter Login"),
          ElevatedButton(
            onPressed: () async {
              print("hello");

              try {
                final twitterLogin = TwitterLogin(
                  apiKey: "K2dxjejPuEskmB4LuXSCaX5a2",
                  apiSecretKey: "v035Z6gfARogTBqbi2hSsQkhAOR3iTVIUo89VBCz9MJbogyHyx",
                  redirectURI: "https://buffer-52eee.firebaseapp.com/__/auth/handler",
                );

                final authResult = await twitterLogin.login();
                final AuthCredential credential = TwitterAuthProvider.credential(
                  accessToken: authResult.authToken!,
                  secret: authResult.authTokenSecret!,
                );

                await FirebaseAuth.instance.signInWithCredential(credential);

                setState(() {
                  isLoading = true;
                });
              } on PlatformException {
                print('Issue in Platform');
              }
            },
            child: Text("Log In"),
          ),
          isLoading ? Text("success") : Text("failure")
        ],
      ),
    ));
  }
}
