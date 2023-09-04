import 'package:farmy/screens/scan_images_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../components/disease_item_widget.dart';

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
              vertical: 20,
            ),
            child: Text(
              "Scanned Diseases",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: 100,
              ),
              children: [
                DiseaseItemWidget(),
                DiseaseItemWidget(),
                DiseaseItemWidget(),
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
                color: Colors.white,
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.lightGreen,
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
