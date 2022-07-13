import 'dart:developer';
import 'dart:io';

import 'package:buffer/helper/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({Key? key}) : super(key: key);

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  File? profilepic;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  void saveUser(File profilePic) async {
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
      UploadTask uploadTask = FirebaseStorage.instance.ref().child("profilepictures").child(Uuid().v1()).putFile(profilePic);

      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      var myMap = new Map();
      myMap['name'] = name;
      myMap['email'] = email;
      myMap['age'] = age;
      myMap['detailString'] = detailString;
      myMap['image'] = downloadUrl;

      FirebaseDatabase.instance.ref("users").child(FirebaseAuth.instance.currentUser!.uid).set(myMap);

      log("User created!");
    } else {
      log("Please fill all the fields!");
    }

    setState(() {
      profilepic = null;
    });
  }

  getCropImage(XFile? image) async {
    if (image != null) {
      final cropImage = await ImageCropper().cropImage(sourcePath: image.path, compressQuality: 50);
      if (cropImage != null) {
        profilepic = File(cropImage.path);
        setState(() {
          saveUser(profilepic!);
          log("given to editPhoto");
        });
      }
    } else {
      return null;
    }
  }

  getImage(ImageSource source) async {
    XFile? selectedImage = await ImagePicker().pickImage(
      source: source,
    );

    getCropImage(selectedImage);

    if (selectedImage != null) {
      // File convertedFile = File(selectedImage.path);
      // setState(() {
      //   profilepic = convertedFile;
      //   editPhotoUpload();
      // });
      log("Image selected!");
    } else {
      log("No image selected!");
      // Navigator.of(context).pop;

      setState(() {
        profilepic = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Center(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CupertinoButton(
                onPressed: () {
                  _bottomSheetWidget();
                },
                child: CircleAvatar(
                  radius: 53,
                  backgroundColor: whiteColor,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: (profilepic != null) ? FileImage(profilepic!) : null,
                    backgroundColor: Colors.grey,
                  ),
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
                    saveUser(profilepic!);
                  },
                  color: voiletColor,
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
    );
  }

  void _bottomSheetWidget() {
    showModalBottomSheet(
      enableDrag: false,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Pick an Image",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22, color: grey),
            ),
            ListTile(
              leading: const Icon(Icons.camera),
              title: Text('Camera'),
              onTap: () {
                getImage(ImageSource.camera);
                Navigator.of(context).pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.browse_gallery),
              title: Text('Gallery'),
              onTap: () {
                getImage(ImageSource.gallery);
                Navigator.of(context).pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
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
