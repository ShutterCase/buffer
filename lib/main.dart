import 'package:buffer/login_screen.dart';
import 'package:buffer/sign_up.dart';
import 'package:buffer/splash_screen.dart';
import 'package:flutter/material.dart';

import 'intro_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Budget UI',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(
            // primaryColor: Colors.green,
            ),
        // home: SplashScreen(),
        routes: {
          '/': (_) => const SplashScreen(),
          '/introScreen': (_) => const IntroScreen(),
          '/loginScreen': (_) => const LoginScreen(),
          '/signUpScreen': (_) => const SignUpScreen(),
        });
  }
}
