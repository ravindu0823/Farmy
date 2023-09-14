import 'package:farmy/constants.dart';
import 'package:farmy/screens/scan_images_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../components/disease_item_widget.dart';
import '../components/header.dart';

class ScannedDiseasesWidget extends StatefulWidget {
  const ScannedDiseasesWidget({
    super.key,
  });

  @override
  State<ScannedDiseasesWidget> createState() => _ScannedDiseasesWidgetState();
}

class _ScannedDiseasesWidgetState extends State<ScannedDiseasesWidget> {
  SessionManager sessionManager = SessionManager();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Header(),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Text(
              "Scanned Diseases",
              style: TextStyle(
                fontSize: 23,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: 100,
              ),
              children: [
                DiseaseItemWidget(
                  diseaseName: "Disease 1",
                  scannedDate: "Date 1",
                ),
                DiseaseItemWidget(
                  diseaseName: "Disease 2",
                  scannedDate: "Date 2",
                ),
                DiseaseItemWidget(
                  diseaseName: "Disease 3",
                  scannedDate: "Date 3",
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScanImagesPage(),
                ),
              );
            },
            child: Text(
              'Scan Image',
              style: TextStyle(
                color: kTextColor,
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                kPrimaryColor,
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
