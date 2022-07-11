import 'package:buffer/helper/constants.dart';
import 'package:flutter/material.dart';

import '../models/check_box_model.dart';

class CheckBoxScreen extends StatefulWidget {
  const CheckBoxScreen({Key? key}) : super(key: key);

  @override
  _CheckBoxScreenState createState() => _CheckBoxScreenState();
}

class _CheckBoxScreenState extends State<CheckBoxScreen> {
  final allCheckStatus = CheckBox(title: 'Post All');

  final checkBoxList = [
    CheckBox(title: 'Tiktok'),
    CheckBox(title: 'FaceBook'),
    CheckBox(title: 'SnapChat'),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('checkbox'),
        ),
        body: ListView(
          children: [
            buildToggleCheckbox(allCheckStatus),
            const Divider(),
            ...checkBoxList.map(buildSingleCheckbox).toList(),
          ],
        ),
      );

  Widget buildToggleCheckbox(CheckBox checkBox) => buildCheckbox(
      notification: checkBox,
      onClicked: () {
        final newValue = !checkBox.value;

        setState(() {
          allCheckStatus.value = newValue;
          for (var notification in checkBoxList) {
            notification.value = newValue;
          }
        });
      });

  Widget buildSingleCheckbox(CheckBox checkBox) => buildCheckbox(
        notification: checkBox,
        onClicked: () {
          setState(() {
            final newValue = !checkBox.value;
            checkBox.value = newValue;

            if (!newValue) {
              allCheckStatus.value = false;
            } else {
              final allow = checkBoxList.every((notification) => notification.value);
              allCheckStatus.value = allow;
            }
          });
        },
      );

  Widget buildCheckbox({
    required CheckBox notification,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: () {},
        child: ListTile(
          onTap: onClicked,
          leading: Checkbox(
            activeColor: voiletColor,
            value: notification.value,
            onChanged: (value) => onClicked(),
          ),
          title: Text(
            notification.title!,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      );
}
