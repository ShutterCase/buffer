import 'package:buffer/screens/intro_screen.dart';
import 'package:buffer/screens/login_screen.dart';
import 'package:buffer/screens/sign_up.dart';
import 'package:buffer/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/introScreen':
        return MaterialPageRoute(builder: (_) => const IntroScreen());
      case '/loginScreen':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/signUpScreen':
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
    }
    return _errorRoute();
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(child: Text('ERROR')),
      );
    });
  }
}
