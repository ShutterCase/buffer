import 'package:buffer/helper/route_generator.dart';
import 'package:buffer/screens/login_screen.dart';
import 'package:buffer/screens/sign_up.dart';
import 'package:buffer/screens/splash_screen.dart';
import 'package:flutter/material.dart';

import 'screens/intro_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Budget UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
