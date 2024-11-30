import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Modules/Widgets/custom_loading.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CustomLoading(
      leftDotColor: AppColors.primary,
      size: 40.sp,
      rightDotColor: AppColors.secondary,
    ));
  }
}
