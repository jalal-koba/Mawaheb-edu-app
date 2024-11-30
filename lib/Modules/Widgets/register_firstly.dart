import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/images.dart';
import 'package:talents/Constant/public_constant.dart'; 
import 'package:talents/Modules/Auth/View/Screens/login_screen.dart';
import 'package:talents/Modules/Auth/View/Screens/sign_up_screen.dart';
import 'package:talents/Modules/Widgets/custom_button.dart';

class RegisterFirstly extends StatelessWidget {
  const RegisterFirstly({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           Image.asset(
            Images.appLogo,
            width: 60.w,
          ),
          SizedBox(  height: 5.h),
          CustomButton(
            height: 6,
            onPressed: () {
              pushAndRemoveUntiTo(context: context, toPage: const LoginScreen());
              
            },
            titlebutton: "تسجيل الدخول",
          ),
          SizedBox(  height: 3.h),
          CustomButton(
            height: 6,
            onPressed: () {
              pushAndRemoveUntiTo(
                  context: context,
                  toPage: const SignUpScreen(
                    fromHome: true,
                  ));
            },
            titlebutton: "إنشاء حساب",
          )
        ],
      ),
    );
  }
}
