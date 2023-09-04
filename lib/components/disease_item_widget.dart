import 'package:flutter/material.dart';

class DiseaseItemWidget extends StatelessWidget {
  const DiseaseItemWidget({
    super.key,
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
          color: Colors.greenAccent.shade400,
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
                "Disease Name",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Text(
              "Scanned Date",
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
