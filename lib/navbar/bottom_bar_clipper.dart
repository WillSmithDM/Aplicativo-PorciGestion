
import 'package:flutter/material.dart';

class BottomBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final curveHeight = size.height / 10;

    path.moveTo(0, size.height);
    path.lineTo(0, curveHeight);
    path.quadraticBezierTo(
        size.width / 2, 0, size.width, curveHeight);
    path.lineTo(size.width, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}