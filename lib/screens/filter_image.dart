import 'dart:io';
import 'package:flutter/material.dart';

class FilterImage extends StatefulWidget {
  final File postPic;
  const FilterImage({Key? key, required this.postPic}) : super(key: key);

  @override
  State<FilterImage> createState() => _FilterImageState();
}

class _FilterImageState extends State<FilterImage> {
  Color editColor = Colors.transparent;
  BlendMode blendColor = BlendMode.color;

  void changeColor(Color color, BlendMode bColor) {
    setState(() {
      editColor = color;
      blendColor = blendColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(editColor, blendColor),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(widget.postPic),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: imageFilterModel.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        changeColor(imageFilterModel[index].color, imageFilterModel[index].blend);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(imageFilterModel[index].color, imageFilterModel[index].blend),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(
                                        widget.postPic,
                                      ),
                                    ),
                                  ),
                                  height: 80,
                                  width: 80,

                                  // backgroundImage: FileImage(widget.postPic),
                                  // radius: 50,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(imageFilterModel[index].title),
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class ImageFilterModel {
  final String title;
  final Color color;
  final BlendMode blend;

  ImageFilterModel({required this.color, required this.title, required this.blend});
}

List<ImageFilterModel> imageFilterModel = [
  ImageFilterModel(color: Colors.blue, blend: BlendMode.color, title: 'Blue'),
  ImageFilterModel(color: Colors.red, blend: BlendMode.color, title: 'red'),
  ImageFilterModel(color: Colors.yellow, blend: BlendMode.color, title: 'yellow')
];
