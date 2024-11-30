import 'package:flutter/material.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:sizer/sizer.dart';
 
class AppTextStyles {
  static final TextStyle buttonAuthTextStyle = TextStyle(
    fontSize: 14.sp,
    color: Colors.white,
    fontFamily: "tajawal",
  );
//
  static final TextStyle largeTitle = TextStyle(
    fontFamily: "tajawal",
    fontSize: 15.sp,
    color: AppColors.primary,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle meduimTitle = TextStyle(
      fontSize: 14.sp, fontWeight: FontWeight.w400, fontFamily: "tajawal");

  static final TextStyle secondTitle = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
    fontFamily: "tajawal"
  );

  static final TextStyle explanatoryText = TextStyle(
      fontFamily: "tajawal",
      color: Colors.black,
      fontSize: 10.sp,
      fontWeight: FontWeight.w300,
      height: 0.18.h);

  static final TextStyle questionsText = TextStyle(
      fontFamily: "tajawal",
      color: Colors.black,
      fontSize: 11.sp,
      fontWeight: FontWeight.w500 ,
      height: 0);

 
}
