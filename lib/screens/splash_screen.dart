import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateTOHome();
  }

  void _navigateTOHome() {
    Timer(const Duration(seconds: 3),
        () => Navigator.pushNamed(context, '/introScreen'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Lottie.network(
            'https://assets8.lottiefiles.com/private_files/lf30_jspeqlsz.json',
          ),
        ),
      ),
    );
  }
}
