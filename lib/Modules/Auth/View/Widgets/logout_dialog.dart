import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Modules/Auth/Cubit/auth_cubit.dart';
import 'package:talents/Modules/Auth/View/Widgets/custom_text_button.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({
    super.key,
    required this.authCubit,
  });

  final AuthCubit authCubit;

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      duration: const Duration(milliseconds: 400),
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding:
              EdgeInsets.only(top: 0.5.h, bottom: 1.h, left: 2.w, right: 2.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Align(
              //   alignment: Alignment.center,
              //   child: Image.asset(
              //     Images.appLogo,
              //     width: 25.w,
              //   ),
              // ),

              SizedBox(height: 3.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.5.w),
                child: Text('هل أنت متأكد من تسجيل الخروج؟',
                    style: AppTextStyles.meduimTitle),
              ),
              SizedBox(height: 3.h),
              Row(
                children: <Widget>[
                  SizedBox(width: 4.w, height: 0.0),
                  Expanded(
                    child: CustomTextButton(
                      size: Size(20.w, 5.h),
                      textColor: AppColors.primary,
                      title: "إلغاء",
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  SizedBox(width: 4.w, height: 0.0),
                  Expanded(
                    child: CustomTextButton(
                      size: Size(20.w, 5.h),
                      border: const BorderSide(color: Colors.red),
                      textColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 243, 105, 89),
                      title: "نعم",
                      onPressed: () {
                        Navigator.of(context).pop();
                        authCubit.logout();
                      },
                    ),
                  ),
                  SizedBox(width: 4.w, height: 0.0),
                ],
              ),
              SizedBox(width: 0.w, height: 1.h),
            ],
          ),
        ),
      ),
    );
  }
}
