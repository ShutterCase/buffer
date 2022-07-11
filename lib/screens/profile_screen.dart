import 'dart:collection';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../main.dart';
import '../widgets/custom_shape_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  File? profilepic;

  void saveUser() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String ageString = ageController.text.trim();
    String detailString = detailController.text.trim();

    int age = int.parse(ageString);

    nameController.clear();
    emailController.clear();
    ageController.clear();
    detailController.clear();

    if (name != "" && email != "" && detailString != "") {
      UploadTask uploadTask = FirebaseStorage.instance.ref().child("profilepictures").child(Uuid().v1()).putFile(profilepic!);

      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      var myMap = new Map();
      myMap['name'] = 'lostcoder';
      myMap['password'] = 'ihateprogramming';

      FirebaseDatabase.instance.ref("users").child(FirebaseAuth.instance.currentUser!.uid).set(myMap);

      // await ref.set({
      //   "name": name,
      //   "email": email,
      //   "age": age,
      //   "profilePic": downloadUrl,
      //   "detail": detailString,
      //   "UserDetails": [name, email, age, detailString]
      // });

      // Map<String, dynamic> userData = {
      //   "name": name,
      //   "email": email,
      //   "age": age,
      //   "profilepic": downloadUrl,
      //   "detail": detailString,
      //   "UserDetails": [name, email, age, detailString]
      // };
      print('siddhant');
      // print(userData);

      // FirebaseFirestore.instance.collection("users").add(userData);
      log("User created!");
    } else {
      log("Please fill all the fields!");
    }

    setState(() {
      profilepic = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      // appBar: AppBar(
      //   elevation: 0.0,
      //   // toolbarHeight: 200,
      //   // flexibleSpace: ClipPath(
      //   //   clipper: Customshape(),
      //   //   child: Stack(
      //   //     children: [
      //   //       Container(
      //   //         height: 200,
      //   //         width: MediaQuery.of(context).size.width,
      //   //         color: Colors.red,
      //   //       ),
      //   //       Align(
      //   //         alignment: Alignment.bottomCenter,
      //   //         child: CircleAvatar(
      //   //           radius: 50,
      //   //           // backgroundImage:
      //   //           // (profilepic != null) ? FileImage(profilepic!) : null,
      //   //           backgroundColor: Colors.grey,
      //   //         ),
      //   //       )
      //   //     ],
      //   //   ),
      //   // ),
      //   backgroundColor: const Color(0xff555555),
      //   // title: const Text('Profile Screen'),
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Center(
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CupertinoButton(
                  onPressed: () async {
                    XFile? selectedImage = await ImagePicker().pickImage(source: ImageSource.camera);

                    if (selectedImage != null) {
                      File convertedFile = File(selectedImage.path);
                      setState(() {
                        profilepic = convertedFile;
                      });
                      log("Image selected!");
                    } else {
                      log("No image selected!");
                    }
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: (profilepic != null) ? FileImage(profilepic!) : null,
                    backgroundColor: Colors.grey,
                  ),
                ),
                textField(
                  hintText: 'Name',
                  controller: nameController,
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.07),
                textField(
                  hintText: 'Email',
                  controller: emailController,
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.07),
                textField(
                  hintText: 'Age',
                  controller: ageController,
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.07),
                textField(
                  hintText: 'Detail',
                  controller: detailController,
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.07),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () {
                      saveUser();
                    },
                    color: Colors.black54,
                    child: const Center(
                      child: Text(
                        "Update",
                        style: TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textField({required hintText, required TextEditingController controller}) {
    return Material(
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              letterSpacing: 2,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
            fillColor: Colors.white30,
            filled: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none)),
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color(0xff555555);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
//
// CircleAvatar(
// backgroundColor: Colors.black54,
// child: IconButton(
// icon: Icon(
// Icons.edit,
// color: Colors.white,
// ),
// onPressed: () {},
// ),
// ),
