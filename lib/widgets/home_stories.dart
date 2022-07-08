import 'package:buffer/constants.dart';
import 'package:flutter/material.dart';

class HomeStories extends StatelessWidget {
  const HomeStories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                "Stories",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: const <Widget>[Icon(Icons.play_arrow), Text("Watch All", style: TextStyle(fontWeight: FontWeight.bold))],
              )
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 10),
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) => Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: whiteColor,
                    image: DecorationImage(fit: BoxFit.fill, image: NetworkImage("https://pbs.twimg.com/profile_images/916384996092448768/PF1TSFOE_400x400.jpg")),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                ),
                index == 0
                    ? const Positioned(
                        right: 10.0,
                        child: CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          radius: 10.0,
                          child: Icon(
                            Icons.add,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ))
                    : Container()
              ],
            ),
          ),
        ),
      ],
    );
  }
}
