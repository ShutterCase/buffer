import 'package:buffer/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.80,
            child: PageView(
              controller: controller,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 100),
                  child: Image.asset("assets/1.png"),
                ),
                Image.asset("assets/2.png"),
                Image.asset("assets/3.png"),
                Image.asset("assets/4.png"),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.20,
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SmoothPageIndicator(
                controller: controller,
                count: 4,
                effect: const SlideEffect(radius: 5.0, strokeWidth: 1.5, dotColor: Colors.white, activeDotColor: Colors.indigo),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        height: MediaQuery.of(context).size.height * 0.20,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50), elevation: 0, primary: voiletColor),

              onPressed: () {
                Navigator.pushNamed(context, '/signUpScreen');

                // signIn();
              },
              child: const Text(
                "I'm am new to Buffer , let's signUp.",
                style: TextStyle(color: whiteColor),
              ),
              // icon: const Icon(Icons.lock_open),
              // label: const Text('I am new to buffer , signUp'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/loginScreen');
              },
              child: const Text(
                'I already have a $bufferAccount',
                style: TextStyle(color: whiteColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
