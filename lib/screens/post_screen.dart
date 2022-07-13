import 'dart:developer';
import 'dart:io';

import 'package:buffer/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  File? postPic;

  getPostToFirebase(File image) async {
    String title = titleController.text.trim();
    String description = descriptionController.text.trim();

    titleController.clear();
    descriptionController.clear();

    if (title != "" && description != "") {
      UploadTask uploadTask = FirebaseStorage.instance.ref().child("postImage").child(Uuid().v1()).putFile(image);

      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      var postMap = new Map();
      postMap['title'] = title;
      postMap['description'] = description;
      postMap['Image'] = downloadUrl;
      FirebaseDatabase.instance.ref("post").child(FirebaseAuth.instance.currentUser!.uid).set(postMap);
      log(" updated");
    } else {
      log("Not updated");
    }

    setState(() {
      postPic = null;
    });
  }

  getCropImage(XFile? image) async {
    if (image != null) {
      final cropImage = await ImageCropper().cropImage(sourcePath: image.path, compressQuality: 50);
      if (cropImage != null) {
        postPic = File(cropImage.path);
        setState(() {
          getPostToFirebase(postPic!);
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

    getCropImage(selectedImage!);

    if (selectedImage != null) {
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
              GestureDetector(
                onTap: () {
                  getImage(ImageSource.camera);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Image.network(
                      "https://designshack.net/wp-content/uploads/placeholder-image.png",
                      fit: BoxFit.cover,
                      height: double.maxFinite,
                      width: double.maxFinite,
                    ),
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
          child: Icon(Icons.share),
          onPressed: () {
            getPostToFirebase(postPic!);
          }),
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
