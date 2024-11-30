import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';

class DrawerButton extends StatelessWidget {
  const DrawerButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final Function()? onPressed;
  final String title;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            minimumSize: Size(100.w, 5.h), overlayColor: AppColors.primary),
        onPressed: onPressed,
        child: Text(
          title,
          style: AppTextStyles.meduimTitle.copyWith(
              fontSize: 12.sp,
              color: Colors.black,
              fontWeight: FontWeight.w500),
        ));
  }
}
