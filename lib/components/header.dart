import 'package:flutter/material.dart';

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
              child: const Text(
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
          margin: const EdgeInsets.symmetric(
            vertical: 25,
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 23,
            ),
          ),
        ),
      ],
    );
  }
}
