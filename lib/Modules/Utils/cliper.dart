import 'package:flutter/material.dart';

class Cliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double y = size.height;

    double x = size.width;

    Path path = Path();


    path.moveTo(0, y);


    path.lineTo(0, y * 0.40);
    path.lineTo(x*0.018, y * 0.20);

    path.quadraticBezierTo(0.05 * x, y * 0.08, x * 0.18, y * 0.1);


    path.lineTo(x, y * 0.24);
    path.lineTo(x, y);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
