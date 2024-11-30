import 'package:animate_do/animate_do.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/images.dart';

class CompanyInfo extends StatelessWidget {
  const CompanyInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElasticIn(
              child: Image.asset(
                Images.icr,
                width: 6.w,
              ),
            ),
            const SizedBox(width: 1.7,  ),
            Text(
              'Developed and desigend by ',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontFamily: "inter",
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
        InkWell(highlightColor: Colors.transparent,splashColor: Colors.transparent,
          onTap: () async => await EasyLauncher.email(
              email: 'IdeaCodeReality.ICR@gmail.com'),
          child: Text(
            'IdeaCodeReality.ICR@gmail.com',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 10.sp,
                decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }
}
