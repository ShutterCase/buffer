import 'package:flutter/material.dart';

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({Key? key}) : super(key: key);

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, right: 10, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                child: const Center(
                  child: Text(
                    'Connect Your Apps',
                    style: TextStyle(fontSize: 34),
                  ),
                ),
              ),
              ConnectCards(
                  title: "FaceBook",
                  onTap: () {
                    print('fb');
                  }),
              ConnectCards(
                  title: "Instagram",
                  onTap: () {
                    print('Insta');
                  }),
              ConnectCards(title: "Twitter", onTap: () {}),
              ConnectCards(title: "Pinterest", onTap: () {}),
              ConnectCards(title: "Reddit", onTap: () {}),
              ConnectCards(title: "Reddit", onTap: () {}),
              ConnectCards(title: "Reddit", onTap: () {}),
              ConnectCards(title: "Reddit", onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

class ConnectCards extends StatefulWidget {
  final String title;

  final VoidCallback onTap;
  const ConnectCards({Key? key, required this.title, required this.onTap}) : super(key: key);

  @override
  State<ConnectCards> createState() => _ConnectCardsState();
}

class _ConnectCardsState extends State<ConnectCards> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(widget.title),
      subtitle: const Text('Add Your Social Account'),
      trailing: ElevatedButton(
        onPressed: widget.onTap,
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          side: const BorderSide(color: Colors.green, width: 2),
        ),
        child: const Text('Connect'),
      ),
    );
  }
}
