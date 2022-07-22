import 'dart:developer';
import 'dart:io';
import 'package:buffer/helper/utils.dart';
import 'package:buffer/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
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

  bool _isSelected1 = false;
  bool _isSelected2 = false;
  bool _isSelected3 = false;
  bool _isSelected4 = false;
  bool _isSelected5 = false;

  getCropImage(XFile? image) async {
    if (image != null) {
      final cropImage = await ImageCropper().cropImage(sourcePath: image.path, compressQuality: 50);
      if (cropImage != null) {
        setState(() {
          postPic = File(cropImage.path);
          log("postPic get the image to display");
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        child: Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.22),
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
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.30,
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Title",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    CustomTextField(textEditingController: titleController, textInputType: TextInputType.name, hintText: 'Title'),
                    const Text(
                      "Description",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    CustomTextField(
                      textEditingController: descriptionController,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.name,
                      hintText: 'Add Your Bio',
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              Wrap(runSpacing: 0.5, spacing: 10, children: [
                FilterChip(
                  label: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    child: Text("Facebook"),
                  ),
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                  selected: _isSelected1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  backgroundColor: Colors.blue.withOpacity(0.50),
                  onSelected: (isSelected) {
                    setState(() {
                      _isSelected1 = isSelected;
                    });
                  },
                  selectedColor: Colors.blue,
                ),
                FilterChip(
                  label: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    child: Text("Instagram"),
                  ),
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                  selected: _isSelected2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  backgroundColor: Colors.pink.withOpacity(0.50),
                  onSelected: (isSelected) {
                    setState(() {
                      _isSelected2 = isSelected;
                    });
                  },
                  selectedColor: Colors.pink,
                ),
                FilterChip(
                  label: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    child: Text("LinkDin"),
                  ),
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                  selected: _isSelected3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  backgroundColor: Colors.lightBlueAccent.withOpacity(0.50),
                  onSelected: (isSelected) {
                    setState(() {
                      _isSelected3 = isSelected;
                    });
                  },
                  selectedColor: Colors.lightBlueAccent,
                ),
                FilterChip(
                  label: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    child: Text("Twitter"),
                  ),
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                  selected: _isSelected4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  backgroundColor: Colors.orange.withOpacity(0.50),
                  onSelected: (isSelected) {
                    setState(() {
                      _isSelected4 = isSelected;
                    });
                  },
                  selectedColor: Colors.orange,
                ),
                FilterChip(
                  label: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    child: Text("Pinterest"),
                  ),
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                  selected: _isSelected5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  backgroundColor: Colors.red.withOpacity(0.50),
                  onSelected: (isSelected) {
                    setState(() {
                      _isSelected5 = isSelected;
                    });
                  },
                  selectedColor: Colors.red,
                ),
              ]),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: voiletColor),
                  onPressed: () {
                    setState(() {
                      if (_isSelected1 || _isSelected2 || _isSelected3 || _isSelected4 || _isSelected5 == true) {
                        log('Perform Task');
                      } else {
                        log("Something Missing");
                      }
                    });
                  },
                  child: const Center(
                    child: Text(
                      "Post",
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
      // floatingActionButton: FloatingActionButton(
      //     child: const Icon(Icons.share),
      //     onPressed: () {
      //       setState(() {
      //         if (_isSelected1 || _isSelected2 || _isSelected3 || _isSelected4 || _isSelected5 == true) {
      //           log('Perform Task');
      //         } else {
      //           log("Something Missing");
      //         }
      //       });
      //     }),
    );
  }

  void _bottomSheetWidget() {
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
      builder: (context) => WillPopScope(
        onWillPop: () async {
          print('close sheet');
          return true;
        },
        child: Padding(
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
      ),
    );
  }
}

// class FilterChipWidget extends StatefulWidget {
//   final Color? color;
//   final String? chipName;
//   bool isSelected;
//   FilterChipWidget({
//     this.chipName,
//     this.color,
//     this.isSelected = false,
//   });
//
//   @override
//   _FilterChipWidgetState createState() => _FilterChipWidgetState();
// }
//
// class _FilterChipWidgetState extends State<FilterChipWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return FilterChip(
//       label: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 3),
//         child: Text(widget.chipName!),
//       ),
//       labelStyle: const TextStyle(
//         color: Colors.white,
//         fontSize: 16.0,
//         fontWeight: FontWeight.w400,
//       ),
//       selected: widget.isSelected,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(30.0),
//       ),
//       backgroundColor: widget.color!.withOpacity(0.50),
//       onSelected: (isSelected) {
//         setState(() {
//           widget.isSelected = isSelected;
//           if (widget.isSelected == true) {
//             print("checker true");
//           } else
//             print("checker false");
//         });
//       },
//       // selectedColor: Color(0xffeadffd),
//       selectedColor: widget.color,
//     );
//   }
// }
