import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Modules/Widgets/app_shimmer.dart';

class CustomShimmerCard extends StatelessWidget {
  const CustomShimmerCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.symmetric(horizontal: 3.w),
      decoration: BoxDecoration(
          color: AppColors.superLightBlue,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Expanded(
              child: AppShimmer(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.grey,
              ),
            ),
          )),
          AppShimmer(
            baseColor: Colors.grey[400],
            child: Container(
              height: 4.h,
              width: 50.w,
              decoration: const BoxDecoration(
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    );
  }
}
