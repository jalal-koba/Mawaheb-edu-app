import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Modules/Widgets/app_shimmer.dart';
import 'package:talents/Modules/Widgets/description_shimmer.dart';

class HomeLibraryShimmer extends StatelessWidget {
  const HomeLibraryShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppShimmer(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(20),
            ),
            height: 22.h,
            width: 100.w,
            clipBehavior: Clip.hardEdge,
            margin: EdgeInsets.symmetric(
              horizontal: 4.w,
            ),
          ),
        ),
        SizedBox(height: 1.h),
          const DescriptionShimmer(linesNumber: 3,),
        SizedBox(height: 2.h),
      ],
    );
  }
}
