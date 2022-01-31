// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_editor2/screens/test_editor.dart';
import 'package:image_picker/image_picker.dart';

class MyCamera extends StatefulWidget {
  @override
  _MyCameraState createState() => _MyCameraState();
}

class _MyCameraState extends State<MyCamera> {
  String dirPath = '';
  File? imageFile;

  _initialImageView() {
    if (imageFile == null) {
      return const Text(
        'No Image Selected...',
        style: TextStyle(fontSize: 20.0),
      );
    } else {
      return Card(child: Image.file(imageFile!, width: 400.0, height: 400));
    }
  }

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(picture!.path);
      dirPath = picture.path;
      print('path');
      print(dirPath);
    });
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      // imageFile = picture as File;
      imageFile = File(picture!.path);
      dirPath = picture.path;
      print('path');
      print(dirPath);
    });
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Take Image From...'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: const Text('Gallery'),
                    onTap: () {
                      _openGallery(context);
                      Navigator.of(context).pop();
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: const Text('Camera'),
                    onTap: () {
                      _openCamera(context);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _initialImageView(),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30.0),
                  width: 250.0,
                  child: FlatButton(
                    child: const Text(
                      'Select Image',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                    onPressed: () {
                      _showChoiceDialog(context);
                    },
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30.0),
                  width: 250.0,
                  child: FlatButton(
                    child: const Text(
                      'Image Editor',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FlutterPainterExample(
                            filePath: dirPath,
                          ),
                        ),
                      );
                    },
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
