import 'package:flutter/material.dart';

import 'home_card_list.dart';
import 'home_stories.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: MediaQuery.of(context).size.height * 0.17, child: const HomeStories()),
        const HomeCardList(),
      ],
    );
  }
}
