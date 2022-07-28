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

import 'custom_text_field.dart';

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
      if (profilepic != null) {
        UploadTask uploadTask = FirebaseStorage.instance.ref().child("profilepictures").child(Uuid().v1()).putFile(profilepic!);

        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        var myMap = Map();
        myMap['name'] = name;
        myMap['email'] = email;
        myMap['age'] = age;
        myMap['detailString'] = detailString;
        myMap['image'] = downloadUrl;

        FirebaseDatabase.instance.ref("users").child(FirebaseAuth.instance.currentUser!.uid).set(myMap);
      } else {
        var myMap = Map();
        myMap['name'] = name;
        myMap['email'] = email;
        myMap['age'] = age;
        myMap['detailString'] = detailString;
        myMap['image'] = emptyImageString;

        FirebaseDatabase.instance.ref("users").child(FirebaseAuth.instance.currentUser!.uid).set(myMap);
      }

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
        setState(() {
          profilepic = File(cropImage.path);
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
    return Center(
      child: SingleChildScrollView(
        // reverse: true,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.maxFinite,
              color: Colors.black,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/png.png',
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CupertinoButton(
                      onPressed: () {
                        _bottomSheetWidget();
                      },
                      child: CircleAvatar(
                          radius: 60,
                          backgroundColor: whiteColor,
                          child: (profilepic != null)
                              ? CircleAvatar(
                                  radius: 55,
                                  backgroundImage: FileImage(profilepic!),
                                  backgroundColor: Colors.grey,
                                )
                              : const CircleAvatar(
                                  radius: 55,
                                  backgroundImage: AssetImage('assets/img_avatar.png'),
                                  backgroundColor: Colors.grey,
                                )),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: MediaQuery.of(context).size.height * 0.45,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomTextField(
                    maxLines: 1,
                    textEditingController: nameController,
                    textInputType: TextInputType.name,
                    hintText: 'Name',
                  ),
                  CustomTextField(
                    maxLines: 1,
                    // validator: (value) => EmailValidator.validate(value!) ? null : "Please enter a valid email",
                    textEditingController: emailController,
                    textInputType: TextInputType.emailAddress,
                    hintText: 'E-mail',
                  ),
                  CustomTextField(
                    maxLines: 1,
                    textEditingController: ageController,
                    textInputType: TextInputType.number,
                    hintText: 'Age',
                  ),
                  CustomTextField(
                    maxLines: 1,
                    textInputAction: TextInputAction.done,
                    textEditingController: detailController,
                    textInputType: TextInputType.text,
                    hintText: 'Detail',
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  saveUser();
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
            ),
          ],
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
              title: const Text('Camera'),
              onTap: () {
                getImage(ImageSource.camera);
                Navigator.of(context).pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.browse_gallery),
              title: const Text('Gallery'),
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
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Material(
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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
        ),
      ),
    ),
  );
}
