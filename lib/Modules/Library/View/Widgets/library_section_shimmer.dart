import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart'; 
import 'package:talents/Modules/Widgets/custom_shimmer_card.dart';

class LibrarySectionShimmer extends StatelessWidget {
  const LibrarySectionShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 2,
        padding:
            EdgeInsets.only(left: 2.w, right: 2.w, top: 2.h, bottom: 1.5.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1.1,
            crossAxisCount: 2,
            crossAxisSpacing: 1.w,
            mainAxisSpacing: 2.h),
        itemBuilder: (context, index) => const CustomShimmerCard());
  }
}
