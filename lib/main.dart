import 'package:buffer/helper/constants.dart';
import 'package:buffer/helper/route_generator.dart';
import 'package:buffer/screens/home_screen.dart';
import 'package:buffer/screens/login_screen.dart';
import 'package:buffer/screens/sign_up.dart';
import 'package:buffer/screens/splash_screen.dart';
import 'package:buffer/widgets/custom_nav_bar.dart';
import 'package:buffer/widgets/loading_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'helper/utils.dart';
import 'screens/intro_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      title: 'Buffer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(brightness: Brightness.dark, scaffoldBackgroundColor: Colors.black, appBarTheme: AppBarTheme(color: Colors.black)),
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: LoadingIndicatorWidget());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Something Went Wrong'));
            } else if (snapshot.hasData) {
              return const CustomNavigationBar();
            } else {
              return const IntroScreen();
              // return const AuthPage();
            }
          }),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
