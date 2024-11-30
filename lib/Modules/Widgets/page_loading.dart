import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart';

class PageLoading extends StatelessWidget {
  const PageLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
       
        child:
            LoadingAnimationWidget.fourRotatingDots(
                color: AppColors.primary, size: 30.sp));
  }
}
