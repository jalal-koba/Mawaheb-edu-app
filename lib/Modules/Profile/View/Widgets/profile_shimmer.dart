 import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Widgets/app_shimmer.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: ListView(
        children: [
          SizedBox(height: 5.h),
          Container(
              width: 35.w,
              height: 35.w,
              decoration: BoxDecoration(
                boxShadow: boxShadow,
                border: Border.all(color: AppColors.primary, width: 0.5),
                shape: BoxShape.circle,
              )),
          SizedBox(
            height: 3.h,
          ),
          ...List.generate(
            6,
            (index) => Container(
              margin: EdgeInsets.only(bottom: 3.h, left: 4.w, right: 4.w),
              // width: 80.w,

              height: 7.h,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(20)),
            ),
          )
        ],
      ),
    );
  }
}
