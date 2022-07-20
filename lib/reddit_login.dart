import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RedditTestScreen extends StatefulWidget {
  const RedditTestScreen({Key? key}) : super(key: key);

  @override
  State<RedditTestScreen> createState() => _RedditTestScreen();
}

class _RedditTestScreen extends State<RedditTestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Reddit Login',
              style: TextStyle(fontSize: 30),
            ),
            ElevatedButton(onPressed: () async {}, child: Text("Reddit Login")),
            ElevatedButton(onPressed: () {}, child: Text("Reddit LogOut")),
          ],
        ),
      ),
    );
  }
}
