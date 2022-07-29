import 'dart:developer';

import 'package:buffer/fb_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twitter_login/twitter_login.dart';

class TwitterTestLogin extends StatefulWidget {
  const TwitterTestLogin({Key? key}) : super(key: key);

  @override
  State<TwitterTestLogin> createState() => _TwitterTestLogin();
}

class _TwitterTestLogin extends State<TwitterTestLogin> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text("Twitter Login"),
          ElevatedButton(
            onPressed: () async {
              log("Start");

              try {
                final twitterLogin = TwitterLogin(
                  apiKey: "K2dxjejPuEskmB4LuXSCaX5a2",
                  apiSecretKey: "v035Z6gfARogTBqbi2hSsQkhAOR3iTVIUo89VBCz9MJbogyHyx",
                  redirectURI: "https://buffer-52eee.firebaseapp.com/__/auth/handler",
                );

                final authResult = await twitterLogin.login();
                switch (authResult.status) {
                  case TwitterLoginStatus.loggedIn:
                    log("success");
                    await twitterLogin.login().then((value) async {
                      final twitterAuthCredential = TwitterAuthProvider.credential(
                        accessToken: value.authToken!,
                        secret: value.authTokenSecret!,
                      );

                      await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
                      setState(() {
                        isLoading = false;
                      });
                    });

                    // final AuthCredential credential =
                    //     TwitterAuthProvider.credential(
                    //   accessToken: authResult.authToken!,
                    //   secret: authResult.authTokenSecret!,
                    // );
                    //
                    // await FirebaseAuth.instance
                    //     .signInWithCredential(credential);
                    //
                    // setState(() {
                    //   isLoading = true;
                    //   log("true");
                    // });
                    // success
                    break;
                  case TwitterLoginStatus.cancelledByUser:

                    // cancel
                    log("cancel");
                    break;
                  case TwitterLoginStatus.error:
                    // error
                    log("error");
                    break;
                  default:
                    break;
                }
              } on PlatformException {
                print('Issue in Platform');
              }
            },
            child: const Text("Log In"),
          ),
          isLoading ? const Text("success") : const Text("failure")
        ],
      ),
    ));
  }
}
