import 'package:buffer/constants.dart';
import 'package:buffer/models/home_stories_model.dart';
import 'package:flutter/material.dart';

class HomeStories extends StatelessWidget {
  const HomeStories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
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
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 5),
                scrollDirection: Axis.horizontal,
                itemCount: homeStoriesModel.length,
                itemBuilder: (context, index) {
                  var data = homeStoriesModel[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                data.image,
                              ),
                              radius: 30,
                              child: homeStoriesModel[index].activeStories == "Active"
                                  ? const Align(
                                      alignment: Alignment.bottomRight,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.blueAccent,
                                        radius: 10.0,
                                        child: Icon(
                                          Icons.add,
                                          size: 14.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        data.title,
                        style: TextStyle(fontSize: 12, color: grey),
                      )
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
