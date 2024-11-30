import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.titlebutton,
    required this.onPressed,
    this.fontSize = 14,
    this.background,
    this.margin,
    this.width = 100,
    this.height = 6.5,
  });
  final String titlebutton;
  final Function()? onPressed;

  final Color? background;
  final EdgeInsetsGeometry? margin;
  final double width;
  final double height;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: AppColors.superLightBlue,
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      child: Container(
          padding: EdgeInsets.all(1.w),
          margin: margin ?? const EdgeInsets.all(3),
          alignment: Alignment.center,
          width: width.w + 20,
          height: height.h, 
          decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(30),
              gradient: background == null
                  ? const LinearGradient(colors: [
                      AppColors.buttonColor,
                      AppColors.favoriteBlue,
                    ], begin: Alignment.bottomCenter, end: Alignment.topCenter)
                  : null),
          child: Text(titlebutton,
              style: AppTextStyles.buttonAuthTextStyle
                  .copyWith(fontSize: fontSize.sp))),
    );
  }
}
