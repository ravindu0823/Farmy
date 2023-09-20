
import 'package:farmy/components/header.dart';
import 'package:farmy/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TreatmentsPage extends StatefulWidget {
  final String diseaseName;

  const TreatmentsPage({super.key, required this.diseaseName});

  @override
  State<TreatmentsPage> createState() => _TreatmentsPageState();
}

class _TreatmentsPageState extends State<TreatmentsPage> {
  final DatabaseReference ref = FirebaseDatabase.instance.ref();
  String diseaseName = "";
  String desc = "";

  Future<void> getData() async {
    final data = await ref.child("Treatments").child(widget.diseaseName).once();

    setState(() {
      diseaseName = data.snapshot.key.toString();
      desc = data.snapshot.value.toString();
    });

    print(diseaseName);
    print(desc);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ).copyWith(
            bottom: 30,
          ),
          child: Column(
            children: [
              const Header(title: "Treatments"),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: kPrimaryColor,
                    width: 3,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      diseaseName.replaceAll("_", " "),
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: kBorderColor,
                      width: 3,
                    ),
                  ),
                  child: ListView(
                    children: [
                      Text(
                        desc,
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
