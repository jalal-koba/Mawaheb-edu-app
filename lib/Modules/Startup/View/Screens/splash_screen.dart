import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Helper/app_sharedPreferance.dart';
import 'package:talents/Modules/Home/View/Screens/main_page.dart';
import 'package:talents/Modules/Startup/View/Screens/on_boarding_screen.dart';
import 'package:talents/Modules/Utils/cliper.dart';
import 'package:talents/Constant/Images.dart';
import 'package:talents/Constant/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      pushAndRemoveUntiTo(
          context: context,
          milliseconds: 1000,
          toPage: AppSharedPreferences.hasToken
              ? const MainPage()
              : const Onboarding(),
          pageTransitionType: AppSharedPreferences.hasToken
              ? PageTransitionType.fade
              : PageTransitionType.topToBottom);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 18.h),
            FadeInUpBig(
              duration: const Duration(milliseconds: 1000),
              child: Image.asset(
                Images.appLogo,
                height: 15.h,
              ),
            ),
            SizedBox(height: 18.h),
            FadeInUpBig(
              child: ClipPath(
                clipper: Cliper(),
                child: Container(
                  width: 100.w,
                  height: 53.h,
                  color: AppColors.secondary,
                  child:
                      Image.asset(fit: BoxFit.cover, Images.splashCliperBack),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
