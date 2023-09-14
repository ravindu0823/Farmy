import 'package:farmy/constants.dart';
import 'package:farmy/screens/scan_images_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../components/disease_item_widget.dart';
import '../components/header.dart';

SessionManager sessionManager = SessionManager();
final DatabaseReference ref = FirebaseDatabase.instance.ref();

class ScannedDiseasesWidget extends StatefulWidget {
  const ScannedDiseasesWidget({
    super.key,
  });

  @override
  State<ScannedDiseasesWidget> createState() => _ScannedDiseasesWidgetState();
}

class _ScannedDiseasesWidgetState extends State<ScannedDiseasesWidget> {
  String username = "";

  Future<void> diseaseData() async {
    var data = await sessionManager.get("username");
    setState(() {
      username = data;
    });
  }

  @override
  void initState() {
    super.initState();
    diseaseData();
  }

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
          DiseaseStreamWidget(
            username: username,
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

class DiseaseStreamWidget extends StatelessWidget {
  final String username;

  const DiseaseStreamWidget({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ref.child("Diseases/$username").onValue,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<DiseaseItemWidget> diseaseWidgets = [];
          for (DataSnapshot dataSnapshot in snapshot.data!.snapshot.children) {
            var temp = dataSnapshot.key!.split("_");
            var diseaseName = temp.join(" ");
            final widget = DiseaseItemWidget(
              diseaseName: diseaseName,
              scannedDate: dataSnapshot.value.toString(),
            );
            diseaseWidgets.add(widget);
          }

          return Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: 100,
              ),
              children: diseaseWidgets,
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightGreenAccent,
            ),
          );
        }
      },
    );
  }
}
