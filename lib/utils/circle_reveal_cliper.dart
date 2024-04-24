import 'package:flutter/material.dart';

class CircleRevealCliper extends CustomClipper<Rect> {
  final double fraction;

  CircleRevealCliper(this.fraction);

  @override
  Rect getClip(Size size) {
    final radius = size.width * fraction;
    // final diameter = 2 * radius;
    final center = Offset(size.width / 2, size.height / 2);
    final topLeft = center - Offset(radius, radius);
    final bottomRight = center + Offset(radius, radius);
    return Rect.fromPoints(topLeft, bottomRight);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return true;
  }
}
