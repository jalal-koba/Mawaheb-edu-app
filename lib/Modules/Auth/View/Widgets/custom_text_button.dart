import 'package:flutter/material.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.title,
    this.size,
    required this.onPressed,
    this.backgroundColor,
    this.border,
    this.textColor,
  });
  final String title;
  final void Function() onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Size? size;
  final BorderSide? border;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            fixedSize: size,
            backgroundColor: backgroundColor ?? Colors.white,
            shape: RoundedRectangleBorder(
                side: border ?? const BorderSide(color: AppColors.secondary),
                borderRadius: BorderRadius.circular(8))),
        onPressed: onPressed,
        child: Text(title,
            style: AppTextStyles.meduimTitle.copyWith(color: textColor)));
  }
}
