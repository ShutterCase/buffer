import 'dart:developer';
import 'dart:io';

import 'package:buffer/helper/utils.dart';
import 'package:buffer/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../helper/constants.dart';
import 'filter_image.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  File? postPic;

  // getPostToFirebase(File image) async {
  //   String title = titleController.text.trim();
  //   String description = descriptionController.text.trim();
  //
  //   titleController.clear();
  //   descriptionController.clear();
  //
  //   if (title != "" && description != "") {
  //     UploadTask uploadTask = FirebaseStorage.instance.ref().child("postImage").child(Uuid().v1()).putFile(image);
  //
  //     TaskSnapshot taskSnapshot = await uploadTask;
  //     String downloadUrl = await taskSnapshot.ref.getDownloadURL();
  //     var postMap = new Map();
  //     postMap['title'] = title;
  //     postMap['description'] = description;
  //     postMap['Image'] = downloadUrl;
  //     FirebaseDatabase.instance.ref("post").child(FirebaseAuth.instance.currentUser!.uid).set(postMap);
  //     log(" updated");
  //   } else {
  //     log("Not updated");
  //   }
  //
  //   setState(() {
  //     postPic = null;
  //   });
  // }

  getCropImage(XFile? image) async {
    if (image != null) {
      final cropImage = await ImageCropper().cropImage(sourcePath: image.path, compressQuality: 50);
      if (cropImage != null) {
        setState(() {
          postPic = File(cropImage.path);
          // getPostToFirebase(postPic!);
          log("postpic get the image to display");
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

    if (selectedImage != null) {
      getCropImage(selectedImage);
      log("Image selected!");
    } else {
      log("No image selected!");

      setState(() {
        postPic = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 30, right: 10, left: 10),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GestureDetector(
                  onTap: () => _bottomSheetWidget(),
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: double.infinity,
                        decoration: postPic != null
                            ? BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: FileImage(postPic!)))
                            : const BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    "https://designshack.net/wp-content/uploads/placeholder-image.png",
                                  ),
                                ),
                              ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          icon: const Icon(Icons.filter),
                          onPressed: () {
                            postPic != null
                                ? Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return FilterImage(
                                          postPic: postPic!,
                                        );
                                      },
                                    ),
                                  )
                                : Utils.showSnackBar("Select an Image");
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Title",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    CustomTextField(textEditingController: titleController, textInputType: TextInputType.name, hintText: 'Title'),
                    const Text(
                      "Description",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    CustomTextField(
                      textEditingController: descriptionController,
                      textInputType: TextInputType.name,
                      hintText: 'Add Your Bio',
                      maxLines: 4,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.30,
                width: double.infinity,
                child: Wrap(runSpacing: 0.5, spacing: 10, children: [
                  FilterChipWidget(
                    chipName: 'FaceBook',
                    color: Colors.blue,
                  ),
                  FilterChipWidget(
                    chipName: 'Pinterest',
                    color: Colors.red,
                  ),
                  FilterChipWidget(
                    chipName: 'TikTok',
                    color: Colors.grey,
                  ),
                  FilterChipWidget(
                    chipName: 'Instagram',
                    color: Colors.purple,
                  ),
                  FilterChipWidget(
                    chipName: 'SnapChat',
                    color: Colors.yellow,
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.share),
          onPressed: () {
            // getPostToFirebase(postPic!);
          }),
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

class FilterChipWidget extends StatefulWidget {
  final Color color;
  final String chipName;

  FilterChipWidget({required this.chipName, required this.color});

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Text(widget.chipName),
      ),
      labelStyle: const TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
      ),
      selected: _isSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      backgroundColor: widget.color.withOpacity(0.50),
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
        });
      },
      // selectedColor: Color(0xffeadffd),
      selectedColor: widget.color,
    );
  }
}
