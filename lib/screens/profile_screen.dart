import 'dart:developer';
import 'dart:io';

import 'package:buffer/helper/constants.dart';
import 'package:buffer/widgets/create_profile.dart';
import 'package:buffer/widgets/loading_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;

  String name = '';
  String email = '';
  int age = 0;
  String detail = "";
  String pic = '';

  File? profilepic;
  CroppedFile? finalCroppedImage;

  void dataChanges() {
    FirebaseDatabase.instance.ref("users").child(FirebaseAuth.instance.currentUser!.uid).onValue.listen((event) {
      var checker = event.snapshot.child("name").value;

      if (checker != null) {
        setState(() {
          name = event.snapshot.child("name").value.toString();
          email = event.snapshot.child("email").value.toString();
          age = event.snapshot.child("age").value as int;
          detail = event.snapshot.child("detailString").value.toString();
          pic = event.snapshot.child("image").value.toString();

          isLoading = true;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  void editPhotoUpload(File finalCroppedImage) async {
    UploadTask uploadTask = FirebaseStorage.instance.ref().child("profilepictures").child(Uuid().v1()).putFile(finalCroppedImage);
    log("run");
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    await FirebaseDatabase.instance.ref("users").child(FirebaseAuth.instance.currentUser!.uid).update({"image": downloadUrl});
    log("compeleted");
  }

  getCropImage(XFile? image) async {
    if (image != null) {
      final cropImage = await ImageCropper().cropImage(sourcePath: image.path, compressQuality: 50);
      if (cropImage != null) {
        File convertedFile = File(cropImage.path);
        setState(() {
          editPhotoUpload(convertedFile);
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
  void initState() {
    // TODO: implement initState

    dataChanges();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Create Profile'),
        // ),
        body: isLoading
            ? Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: Stack(
                          children: [
                            SizedBox(
                              height: double.maxFinite,
                              width: double.maxFinite,
                              child: Stack(
                                children: [
                                  Image.network(
                                    pic,
                                    height: double.maxFinite,
                                    width: double.maxFinite,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    color: Colors.black.withOpacity(0.5),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5, bottom: 7),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.camera,
                                    size: 35,
                                  ),
                                  onPressed: () {
                                    // getImage();
                                    bottomSheetWidget();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        // color: Colors.yellow,
                        height: MediaQuery.of(context).size.height * 0.55,
                        width: double.maxFinite,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 15, left: 15, bottom: 10),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            'Profile',
                            style: TextStyle(color: whiteColor, fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.172),
                        CircleAvatar(
                          radius: 75,
                          backgroundColor: whiteColor,
                          child: CircleAvatar(
                            radius: 70,
                            // backgroundImage: NetworkImage(emptyImageString),

                            backgroundImage: NetworkImage(pic.isEmpty ? emptyImageString : pic),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                        Text(
                          name,
                          style: const TextStyle(color: whiteColor, fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          detail,
                          style: TextStyle(color: grey, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ListTileWidget(
                                name: name,
                                title: 'Name',
                              ),
                              const Divider(height: 2),
                              ListTileWidget(
                                name: email,
                                title: 'Email',
                              ),
                              const Divider(height: 2),
                              ListTileWidget(
                                name: age.toString(),
                                title: 'Age',
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            : const CreateProfile());
  }

  void bottomSheetWidget() {
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

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    Key? key,
    required this.name,
    required this.title,
  }) : super(key: key);

  final String name;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: voiletColor, fontWeight: FontWeight.w600, fontSize: 16),
      ),
      subtitle: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
      ),
      // contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
    );
  }
}
