import 'package:flutter/material.dart' hide DrawerButton;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart';
 import 'package:talents/Constant/images.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Info/View/Screens/contact_with_us_screen.dart';
import 'package:talents/Modules/Info/View/Screens/who_us_screen.dart';
import 'package:talents/Modules/Auth/View/Screens/login_screen.dart';
import 'package:talents/Modules/Auth/View/Screens/sign_up_screen.dart';
import 'package:talents/Modules/Home/Cubit/cubit/main_page_cubit.dart';
import 'package:talents/Modules/Widgets/app_cliper.dart';
 import 'package:talents/Modules/Widgets/custom_button.dart';
import 'package:talents/Modules/Widgets/drawer_button.dart';

 
Drawer appDrawerWithoutLogin(BuildContext context) {
  Divider divider = Divider(
    color: AppColors.primary,
    height: 1.h,
  );
  return Drawer(
    child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipPath(
            clipper: AppCliper(),
            child: Container(
              padding: EdgeInsets.only(bottom: 4.h, top: 3.h),
              width: 100.w,
              height: 13.h,
              decoration: const BoxDecoration(
                color: AppColors.secondary,
              ),
            ),
          ),
          SizedBox(  height: 2.h),
          Image.asset(
            Images.appLogo,
            width: 55.w,
          ),
          SizedBox(  height: 2.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              children: [
                SizedBox(  height: 2.h),
                DrawerButton(
                  title: "مكتبة التطبيق",
                  onPressed: () {
                    Navigator.pop(context);
                    context.read<MainPageCubit>().moveTab(1);
                  },
                ),
                divider,
                DrawerButton(
                  title: "من نحن",
                  onPressed: () {
                    Navigator.pop(context);
                    pushTo(context: context, toPage: const WhoUs());
                  },
                ),
                divider,
                DrawerButton(
                  title: "تواصل معنا",
                  onPressed: () {
                    Navigator.pop(context);
                    pushTo(context: context, toPage: ContactWithUs());
                  },
                ),
                SizedBox(  height: 17.h),
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
                ),
                SizedBox(  height: 4.h),
                // CompanyInfo()
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
