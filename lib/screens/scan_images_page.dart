import 'dart:io';

import 'package:farmy/services/api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ScanImagesPage extends StatefulWidget {
  const ScanImagesPage({super.key});

  @override
  State<ScanImagesPage> createState() => _ScanImagesPageState();
}

class _ScanImagesPageState extends State<ScanImagesPage> {
  Api api = Api();
  final ImagePicker _picker = ImagePicker();
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 15,
            ),
            child: FloatingActionButton(
              backgroundColor: Colors.lightGreen,
              heroTag: "btn1",
              onPressed: () async {
                final XFile? image = await _picker.pickImage(
                  source: ImageSource.camera,
                  maxWidth: 1800,
                  maxHeight: 1800,
                );

                if (image != null) {
                  setState(() {
                    imageFile = File(image.path);
                  });
                }
              },
              child: Icon(
                Icons.camera_alt,
              ),
            ),
          ),
          FloatingActionButton(
            backgroundColor: Colors.lightGreen,
            heroTag: "btn2",
            onPressed: () async {
              final XFile? image = await _picker.pickImage(
                source: ImageSource.gallery,
                maxWidth: 1800,
                maxHeight: 1800,
              );

              if (image != null) {
                setState(() {
                  imageFile = File(image.path);
                });
              }
            },
            child: Icon(
              Icons.photo,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('images/logo.png'),
                  width: 120,
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: 30,
                    left: 20,
                  ),
                  child: Text(
                    'Farmy',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 25,
              ),
              child: Text(
                "Scan Images",
                style: TextStyle(
                  fontSize: 23,
                ),
              ),
            ),
            imageFile != null
                ? Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          bottom: 20,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.lightGreen,
                            width: 4,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            imageFile!,
                            width: 300,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        "Disease Name",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  )
                : Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.lightGreen,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 300,
                    width: 300,
                    child: Center(
                      child: Text(
                        "No image selected",
                      ),
                    ),
                  ),
            ElevatedButton(
              onPressed: () {
                api.upload(imageFile!);
              },
              child: Text("Upload Image"),
            ),
          ],
        ),
      ),
    );
  }
}
