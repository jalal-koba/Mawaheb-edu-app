import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart'; 
import 'package:talents/Modules/Widgets/app_shimmer.dart';

class TrainersShimmer extends StatelessWidget {
  const TrainersShimmer({
    super.key,
    this.itemCount = 10,
    this.isScrollable = true,
  });
  final int itemCount;
  final bool isScrollable;
  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: GridView.builder(
        shrinkWrap: !isScrollable,
        physics: isScrollable
            ? const BouncingScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.7,
            mainAxisSpacing: 1.h,
            crossAxisSpacing: 1.w,
            crossAxisCount: 2),
        itemCount: itemCount,
        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 2.h),
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.all(1.w),
          decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }
}
