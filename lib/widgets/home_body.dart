import 'package:buffer/constants.dart';
import 'package:flutter/material.dart';

import 'home_card_list.dart';
import 'home_stories.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          color: Colors.black12,
          height: MediaQuery.of(context).size.height * 0.19,
          child: const HomeStories(),
        ),
        Container(
          color: Colors.black12,
          height: MediaQuery.of(context).size.height * 0.80,
          child: const HomeCardList(),
        ),
      ],
    );
  }
}
