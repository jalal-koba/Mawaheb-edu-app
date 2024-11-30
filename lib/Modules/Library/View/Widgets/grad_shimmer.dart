import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart'; 
import 'package:talents/Modules/Widgets/custom_shimmer_card.dart';

class GradShimmer extends StatelessWidget {
  const GradShimmer({
    super.key,
    this.isScrollable = false,
  });
  final bool isScrollable;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: isScrollable
            ? const BouncingScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        shrinkWrap: !isScrollable,
        itemCount: 10,
        padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 2.h, bottom: 5.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1.1,
            crossAxisCount: 2,
             mainAxisSpacing: 2.h),
        itemBuilder: (context, index) => const CustomShimmerCard());
  }
}
