import 'package:flutter/material.dart';

class AppCliper extends CustomClipper<Path> {
  
  @override
  Path getClip(Size size) {
    Path path = Path();
    final x = size.width;
    final y = size.height;

    path.lineTo(0, y * 0.65);

    path.lineTo(x * 0.83, y  );

    path.quadraticBezierTo(x * 0.935, y , x * 0.956, y*0.8);

    path.lineTo(x, y*0.45 );
    path.lineTo(x, 0 );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
