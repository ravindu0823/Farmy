import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  final String title;

  const Header({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('images/logo.png'),
              width: 120,
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 30,
                left: 20,
              ),
              child: Text(
                'Farmy',
                style: GoogleFonts.poppins(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: 23,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
