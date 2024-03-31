import 'package:flutter/material.dart';


class DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;
    final Paint paint = Paint()
      ..color =Color(0xFFC5B4FF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.square // Extrémités carrées des lignes
      ..strokeJoin = StrokeJoin.miter; // Jointures carrées des lignes

    final double dashWidth = 5;
    final double dashSpace = 5;
    double currentX = 0;
    double currentY = 0;

    while (currentX <= width) {
      canvas.drawLine(
        Offset(currentX, 0),
        Offset(currentX + dashWidth, 0),
        paint,
      );
      currentX += dashWidth + dashSpace;
    }

    while (currentY <= height) {
      canvas.drawLine(
        Offset(width, currentY),
        Offset(width, currentY + dashWidth),
        paint,
      );
      currentY += dashWidth + dashSpace;
    }

    currentX = width;
    while (currentX >= 0) {
      canvas.drawLine(
        Offset(currentX, height),
        Offset(currentX - dashWidth, height),
        paint,
      );
      currentX -= dashWidth + dashSpace;
    }

    currentY = height;
    while (currentY >= 0) {
      canvas.drawLine(
        Offset(0, currentY),
        Offset(0, currentY - dashWidth),
        paint,
      );
      currentY -= dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}