import 'package:flutter/material.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
      datePickerTheme: DatePickerThemeData(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.transparent,
    headerForegroundColor: Colors.black,
    dayStyle: AppTextStyles.meduimTitle,
    confirmButtonStyle: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
      AppTextStyles.meduimTitle.copyWith(color: AppColors.primary),
    )),
    yearStyle: AppTextStyles.meduimTitle,
    headerHelpStyle:
        AppTextStyles.meduimTitle.copyWith(color: AppColors.primary),
    headerHeadlineStyle:
        AppTextStyles.largeTitle.copyWith(color: AppColors.primary),
    cancelButtonStyle: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
      AppTextStyles.meduimTitle,
    )),
    yearBackgroundColor: WidgetStateProperty.resolveWith(
      (states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }
        return AppColors.superLightBlue;
      },
    ),
    yearForegroundColor: const WidgetStatePropertyAll(Colors.white),
    dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primary;
      }
      return AppColors.superLightBlue;
    }),
  ));
}
