import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:farmy/components/header.dart';
import 'package:farmy/constants.dart';
import 'package:farmy/screens/treatments_page.dart';
import 'package:farmy/services/api.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
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

  SessionManager sessionManager = SessionManager();
  final DatabaseReference ref = FirebaseDatabase.instance.ref();

  void uploadImage(File imageFile) async {
    String result = await api.upload(imageFile);
    String resultTrimmed = result.replaceAll("_", " ");

    result != ""
        ? AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.bottomSlide,
            title: 'Detected Disease',
            desc: 'This plant has a $resultTrimmed disease',
            btnCancelOnPress: () {},
            btnOkText: "View Treatments",
            btnOkOnPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TreatmentsPage(
                    diseaseName: result,
                  ),
                ),
              );
            },
          ).show()
        : AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            animType: AnimType.bottomSlide,
            title: 'Cannot Detect Disease',
            desc: 'Please Try again with a different image',
            btnOkOnPress: () {},
          ).show();
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
              child: const Icon(
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
            child: const Icon(
              Icons.photo,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Header(
              title: 'Scan Images',
            ),
            imageFile != null
                ? Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
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
                    margin: const EdgeInsets.only(
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
                    child: const Center(
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
              child: const Text("Upload Image"),
            ),
          ],
        ),
      ),
    );
  }
}
