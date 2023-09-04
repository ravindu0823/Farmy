import 'package:flutter/material.dart';

class BoundingBoxPainter extends CustomPainter {
  final Rect boundingBox;

  BoundingBoxPainter(this.boundingBox);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final widthScale = size.width;
    final heightScale = size.height;

    final adjustedRect = Rect.fromPoints(
      Offset(boundingBox.left * widthScale, boundingBox.top * heightScale),
      Offset(boundingBox.right * widthScale, boundingBox.bottom * heightScale),
    );

    canvas.drawRect(adjustedRect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
