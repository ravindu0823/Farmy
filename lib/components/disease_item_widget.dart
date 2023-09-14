import 'package:farmy/constants.dart';
import 'package:flutter/material.dart';

class DiseaseItemWidget extends StatelessWidget {
  final String diseaseName;
  final String scannedDate;

  const DiseaseItemWidget({
    super.key,
    required this.diseaseName,
    required this.scannedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        bottom: 20,
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 3,
          color: kBorderColor,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'images/logo.png',
              width: 150,
            ),
            Container(
              margin: EdgeInsets.only(
                top: 10,
              ),
              child: Text(
                diseaseName,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Text(
              scannedDate,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
