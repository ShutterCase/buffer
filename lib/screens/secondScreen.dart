import 'dart:io';

import 'package:buffer/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  File? image;
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick Image $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.check),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.send),
            )
          ],
          backgroundColor: Colors.black54,
          title: Text('New Post')),
      body: ListView(
        children: [
          Container(
            color: black54,
            height: MediaQuery.of(context).size.height * 0.55,
            child: Stack(
              children: [
                image != null
                    ? Expanded(
                        child: Image.file(
                          image!,
                          width: double.maxFinite,
                          height: double.maxFinite,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image.network(
                        "https://i.guim.co.uk/img/media/c8b1d78883dfbe7cd3f112495941ebc0b25d2265/256_0_3840_2304/master/3840.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=3ac0dfad4c2edc23c843d59f1ec08cc8",
                        fit: BoxFit.cover,
                      ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: black54.withOpacity(0.5),
                      child: IconButton(
                        icon: Icon(
                          Icons.zoom_out_map,
                          color: whiteColor,
                          size: 30,
                        ),
                        onPressed: () {
                          pickImage(ImageSource.gallery);
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            // color: Colors.yellow,
            height: MediaQuery.of(context).size.height * 0.08,
            child: ListTile(
              title: Text('Gallery'),
              trailing: IconButton(
                icon: Icon(
                  Icons.camera,
                  color: whiteColor,
                  size: 30,
                ),
                onPressed: () {
                  pickImage(ImageSource.camera);
                },
              ),
            ),
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: 2,
            spacing: 3,
            children: const [
              WrapContent(),
              WrapContent(),
              WrapContent(),
              WrapContent(),
              WrapContent(),
              WrapContent(),
              WrapContent(),
              WrapContent(),
              WrapContent(),
              WrapContent(),
              WrapContent(),
              WrapContent(),
            ],
          )
        ],
      ),
    );
  }
}

class WrapContent extends StatelessWidget {
  const WrapContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      width: MediaQuery.of(context).size.width * 0.327,
      height: MediaQuery.of(context).size.width * 0.32,
      child: Center(
          child: Image.network(
              "https://i.guim.co.uk/img/media/c8b1d78883dfbe7cd3f112495941ebc0b25d2265/256_0_3840_2304/master/3840.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=3ac0dfad4c2edc23c843d59f1ec08cc8")),
    );
  }
}
