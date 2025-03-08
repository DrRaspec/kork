import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnderlineText extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Get.theme.colorScheme.tertiary
      ..strokeWidth = 0.8; // Change this value to adjust thickness
    // 0.5 for thinner line, 1.5 for thicker line

    // Add horizontal offset to shift the entire line to the right
    const horizontalOffset = 2.0; // Adjust this value as needed

    // Calculate where 'g' is likely to be in "Change Email"
    final widthPerChar = size.width / 12;
    final gPosition = widthPerChar * 4.5; // Position of 'g'
    final gWidth = widthPerChar * 1.0; // Approximate width of 'g'

    // Draw first part of line (before 'g'), shifted right
    canvas.drawLine(
      Offset(horizontalOffset, size.height + 2),
      Offset(gPosition + horizontalOffset, size.height + 2),
      paint,
    );

    // Draw second part of line (after 'g'), shifted right
    canvas.drawLine(
      Offset(gPosition + gWidth + horizontalOffset, size.height + 2),
      Offset(size.width + horizontalOffset, size.height + 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
