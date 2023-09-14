import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:farmy/components/header.dart';
import 'package:farmy/constants.dart';
import 'package:farmy/screens/treatments_page.dart';
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
  bool isImageLoaded = false;

  void uploadImage(File imageFile) async {
    String result = await api.upload(imageFile);

    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.bottomSlide,
      title: 'Detected Disease',
      desc: 'This plant has a $result disease',
      btnCancelOnPress: () {},
      btnOkText: "View Treatments",
      btnOkOnPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TreatmentsPage(),
          ),
        );
      },
    )..show();
  }

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
              backgroundColor: kPrimaryColor,
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
                    isImageLoaded = true;
                  });
                }
              },
              child: Icon(
                Icons.camera_alt,
              ),
            ),
          ),
          FloatingActionButton(
            backgroundColor: kPrimaryColor,
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
                  isImageLoaded = true;
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
            Header(),
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
                            color: kPrimaryColor,
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
                    ],
                  )
                : Container(
                    margin: EdgeInsets.only(
                      bottom: 20,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: kPrimaryColor,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 300,
                    width: 300,
                    child: Center(
                      child: Text(
                        "No image selected.\nPlease Upload an Image",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
            ElevatedButton(
              onPressed: isImageLoaded
                  ? () async {
                      uploadImage(imageFile!);
                    }
                  : null,
              child: Text("Upload Image"),
            ),
          ],
        ),
      ),
    );
  }
}
