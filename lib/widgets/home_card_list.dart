import 'package:buffer/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/home_list_model.dart';

class HomeCardList extends StatefulWidget {
  const HomeCardList({Key? key}) : super(key: key);

  @override
  _HomeCardListState createState() => _HomeCardListState();
}

class _HomeCardListState extends State<HomeCardList> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    // var deviceSize = MediaQuery.of(context).size;
    return ListView.separated(
        // physics: NeverScrollableScrollPhysics(),
        primary: false,
        shrinkWrap: true,
        separatorBuilder: (BuildContext context, int index) => const Divider(
              height: 3,
              color: black54,
            ),
        itemCount: homeListModel.length,
        itemBuilder: (context, index) {
          var data = homeListModel[index];
          return Container(
            color: Colors.black12,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ListTile(
                  contentPadding: EdgeInsets.only(left: 10),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      data.image,
                    ),
                  ),
                  title: Text(data.title),
                  subtitle: Text(data.subTitle),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.more_vert,
                      color: whiteColor,
                    ),
                    onPressed: null,
                  ),
                ),
                Image.network(
                  data.image,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              isPressed
                                  ? Icons.favorite
                                  : FontAwesomeIcons.heart,
                              color: isPressed ? Colors.red : whiteColor,
                            ),
                            color: isPressed ? Colors.red : Colors.black,
                            onPressed: () {
                              setState(() {
                                isPressed = !isPressed;
                              });
                            },
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Icon(
                            FontAwesomeIcons.comment,
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          const Icon(FontAwesomeIcons.paperPlane),
                        ],
                      ),
                      const Icon(FontAwesomeIcons.bookmark)
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    data.bottomLikeTitle,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Add a comment...",
                    ),
                  ),
                ),
                // Text("1 Day Ago", style: TextStyle(color: Colors.grey))
              ],
            ),
          );
        });
  }
}
