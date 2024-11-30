import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatelessWidget {
  const AppShimmer({
    super.key,
    required this.child,
    this.baseColor,
    this.highlightColor,
  });
  final Widget child;
  final Color? baseColor, highlightColor;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: baseColor ?? const Color.fromARGB(255, 203, 213, 225),
        highlightColor:
            highlightColor ?? const Color.fromARGB(112, 255, 255, 255),
        child: child);
  }
}
