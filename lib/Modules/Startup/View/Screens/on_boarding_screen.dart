import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/images.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Auth/View/Screens/login_screen.dart';
import 'package:talents/Modules/Utils/cliper.dart';
import 'package:talents/Modules/Widgets/custom_button.dart';
import '../../../Widgets/swaping_point.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  OnboardingState createState() => OnboardingState();
}

class OnboardingState extends State<Onboarding> {
  List<Map> items = [
    {"text": "اهلاً بك في تطبيق مواهب", "img": Images.firstOnBoarding},
    {"text": "طريقك للنجاح", "img": Images.secondOnBoarding},
    {"text": "خطوتك الأولى تبدأ من هنا", "img": Images.thirdOnBoarding},
  ];
  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: 100.w,
          height: 100.h,
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(height: 10.h),
                  FadeInDownBig(
                    child: Image.asset(
                      Images.appLogo,
                      height: 15.h,
                    ),
                  ),
                  const Spacer(),
                  Hero(
                    tag: "tologin",
                    child: ClipPath(
                      clipper: Cliper(),
                      child: Container(
                        width: 100.w,
                        height: 50.h,
                        color: AppColors.secondary,
                        child: Image.asset(
                            fit: BoxFit.cover, Images.splashCliperBack),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  SizedBox(width: 0, height: 30.h),
                  FadeInDownBig(
                    child: SizedBox(
                        height: 40.h,
                        width: 100.w,
                        child: PageView(
                          controller: _pageController,
                          onPageChanged: (value) {
                            currentIndex = value;
                            setState(() {});
                          },
                          children: List.generate(
                            3,
                            (index) => Column(
                              children: <Widget>[
                                if (index == 2) SizedBox(height: 3.h),
                                Expanded(
                                  child: Image.asset(items[index]['img']),
                                ),
                                if (index == 2) SizedBox(height: 3.5.h),
                                Text(
                                  items[index]["text"],
                                  style: AppTextStyles.meduimTitle
                                      .copyWith(fontWeight: FontWeight.w800),
                                )
                              ],
                            ),
                          ),
                        )),
                  ),
                  SizedBox(height: 3.h),
                  SwappingPoint(
                    pageController: _pageController,
                    currentIndex: currentIndex,
                    length: 3,
                  ),
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: CustomButton(
                        titlebutton: "التالي",
                        onPressed: () {
                          if (currentIndex < 2) {
                            _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.linear);
                          } else {
                            pushAndRemoveUntiTo(
                                context: context,
                                toPage: const LoginScreen(),
                                pageTransitionType:
                                    PageTransitionType.bottomToTop);
                          }
                        }),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
