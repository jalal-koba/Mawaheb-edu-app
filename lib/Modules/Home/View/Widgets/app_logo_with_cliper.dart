import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/images.dart';
import 'package:talents/Modules/Widgets/app_cliper.dart';

class AppLogoWithCliper extends StatelessWidget {
  const AppLogoWithCliper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: AppCliper(),
      child: Container(
          padding: EdgeInsets.only(bottom: 4.h, top: 4.5.h),
          width: 100.w,
          height: 15.h,
          decoration: const BoxDecoration(
            color: AppColors.secondary,
          ),
          child: Image.asset(
            Images.appLogo,
          )),
    );
  }
}
