import 'package:flutter/material.dart';
import 'package:talents/Modules/Widgets/app_shimmer.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard(
      {super.key,
      required this.height,
      required this.width,
      this.margin,
      required this.borderRadius});
  final double height, width;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry? margin;
  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Container(
        margin: margin,
        height: height,
        width: width,
        decoration:
            BoxDecoration(color: Colors.grey, borderRadius: borderRadius),
      ),
    );
  }
}
