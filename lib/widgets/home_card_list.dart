import 'package:buffer/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (BuildContext context, int index) => const Divider(
          height: 10,
        ),
        itemCount: 5,
        itemBuilder: (context, index) => Container(
          color: Colors.black12,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 16.0, 0, 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          height: 40.0,
                          width: 40.0,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: whiteColor,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  "https://pbs.twimg.com/profile_images/916384996092448768/PF1TSFOE_400x400.jpg",
                                )),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        const Text(
                          "Post Title",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: null,
                    )
                  ],
                ),
              ),
              Image.network(
                "https://images.pexels.com/photos/672657/pexels-photo-672657.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            isPressed ? Icons.favorite : FontAwesomeIcons.heart,
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
                          width: 16.0,
                        ),
                        const Icon(
                          FontAwesomeIcons.comment,
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        const Icon(FontAwesomeIcons.paperPlane),
                      ],
                    ),
                    const Icon(FontAwesomeIcons.bookmark)
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Liked by Sanjay Gangwar, Sk and 5,331 others",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 40.0,
                      width: 40.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(fit: BoxFit.fill, image: NetworkImage("https://pbs.twimg.com/profile_images/916384996092448768/PF1TSFOE_400x400.jpg")),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Add a comment...",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text("1 Day Ago", style: TextStyle(color: Colors.grey)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
