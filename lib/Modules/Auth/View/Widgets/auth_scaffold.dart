import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/images.dart';
import 'package:talents/Modules/Widgets/app_cliper.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({super.key, required, required this.body, this.tag});
  final Widget body;
  final String? tag;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                Images.appBack,
              ),
              fit: BoxFit.fill)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ClipPath(
          clipper: AppCliper(),
          child: Hero(
            tag: tag ?? "",
            child: Container(
                padding: EdgeInsets.only(bottom: 8.h, top: 6.h),
                width: 100.w,
                height: 22.h,
                decoration: const BoxDecoration(
                  color: AppColors.secondary,
                ),
                child: Image.asset(
                  Images.appLogo,
                )),
          ),
        ),
        SizedBox(height: 5.h),
        body
      ]),
    )));
  }
}
