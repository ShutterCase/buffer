import 'dart:developer';
import 'dart:io';
import 'package:buffer/helper/constants.dart';
import 'package:buffer/helper/utils.dart';
import 'package:buffer/widgets/create_profile.dart';
import 'package:buffer/widgets/loading_indicator.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../widgets/custom_text_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = true;
  bool checker = false;
  String name = '';
  String email = '';
  int age = 0;
  String detail = "";
  String pic = '';

  String updateName = '';
  String updateEmail = '';

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  File? profilepic;

  void dataChanges() {
    FirebaseDatabase.instance.ref("users").child(FirebaseAuth.instance.currentUser!.uid).onValue.listen((event) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });

      var data = event.snapshot.child("name").value;

      if (data != null) {
        if (!mounted) return;
        setState(() {
          name = event.snapshot.child("name").value.toString();
          email = event.snapshot.child("email").value.toString();
          age = event.snapshot.child("age").value as int;
          detail = event.snapshot.child("detailString").value.toString();
          pic = event.snapshot.child("image").value.toString();

          checker = true;

          // LoadingIndicatorWidget();
        });
      } else {
        if (!mounted) return;
        setState(() {
          checker = false;
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
    log("completed");
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
      log("Image selected!");
    } else {
      log("No image selected!");
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
      body: isLoading
          ? const LoadingIndicatorWidget()
          : checker
              ? Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          height: MediaQuery.of(context).size.height * 0.33,
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
                                      height: double.maxFinite,
                                      width: double.maxFinite,
                                      color: Colors.black.withOpacity(0.5),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 7, bottom: 10),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.camera,
                                      size: 35,
                                    ),
                                    onPressed: () {
                                      // getImage();
                                      _bottomSheetWidget();
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
                                  trailing: IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      _editWidget();
                                    },
                                  ),
                                ),
                                const Divider(
                                  height: 3,
                                  color: voiletColor,
                                ),
                                ListTileWidget(
                                  name: email,
                                  title: 'Email',
                                ),
                                const Divider(
                                  height: 3,
                                  color: voiletColor,
                                ),
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
              : const CreateProfile(),
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

  void _editWidget() {
    showModalBottomSheet(
      // enableDrag: false,
      // isDismissible: false,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      context: context,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          // height: MediaQuery.of(context).size.height * 0.4,
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 30),
          child: Wrap(
            // mainAxisSize: MainAxisSize.min,

            children: <Widget>[
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Edit Your Details",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22, color: whiteColor),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                // padding: const EdgeInsets.symmetric(horizontal: 5),
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
                      textEditingController: ageController,
                      textInputType: TextInputType.number,
                      hintText: 'Age',
                      textInputAction: TextInputAction.done,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: voiletColor),
                  onPressed: () {
                    update();
                    Navigator.pop(context);
                  },
                  child: const Center(
                    child: Text(
                      "Confirm",
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
      ),
    );
  }

  void update() async {
    String name = nameController.text.trim();
    String ageString = ageController.text.trim();

    nameController.clear();
    ageController.clear();

    if (name != "" && ageString != "") {
      await FirebaseDatabase.instance.ref("users").child(FirebaseAuth.instance.currentUser!.uid).update({
        "name": name,
        "age": int.parse(ageString),
      });
    } else {
      Utils.showSnackBar('Fill the details');
    }
  }
}

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    Key? key,
    required this.name,
    required this.title,
    this.trailing,
  }) : super(key: key);

  final String name;
  final Widget? trailing;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.10,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
        title: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.005),
          child: Text(
            title,
            style: const TextStyle(color: voiletColor, fontWeight: FontWeight.w600, fontSize: 20),
          ),
        ),
        subtitle: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
        ),
        trailing: trailing,
        // contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
      ),
    );
  }
}
