import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

List<BoxShadow>? blueBoxShadow = const [
  BoxShadow(
    color: AppColors.primary,
    offset: Offset(0, 0.5),
    blurRadius: 1.5,
    spreadRadius: 1,
  )
];

List<BoxShadow>? boxShadow = [
  BoxShadow(
    color: Colors.grey.shade400,
    offset: const Offset(0, 0.5),
    blurRadius: 1.5,
    spreadRadius: 1,
  )
];

List<BoxShadow>? textShadow = const [
  BoxShadow(
    color: Colors.black,
    offset: Offset(0, 0.5),
    blurRadius: 1.5,
    spreadRadius: 1,
  )
];

Future<dynamic> pushTo(
    {required BuildContext context, required Widget toPage}) async {
  return await Navigator.of(context).push(PageTransition(
      duration: const Duration(milliseconds: 450),
      child: toPage,
      type: PageTransitionType.rightToLeft));
}

void pushAndRemoveUntiTo(
    {required BuildContext context,
    required Widget toPage,
    PageTransitionType? pageTransitionType,
    int? milliseconds}) {
  Navigator.of(context).pushAndRemoveUntil(
    PageTransition(
      child: toPage,
      type: pageTransitionType ?? PageTransitionType.rightToLeft,
      duration: Duration(milliseconds: milliseconds ?? 500),
    ),
    (route) => false,
  );
}

void pushReplacement(
    {required BuildContext context,
    required Widget toPage,
    PageTransitionType? pageTransitionType,
    int? milliseconds}) {
  Navigator.of(context).pushReplacement(
    PageTransition(
      child: toPage,
      type: pageTransitionType ?? PageTransitionType.rightToLeft,
      duration: Duration(milliseconds: milliseconds ?? 500),
    ),
  );
}

void customSnackBar(
    {required BuildContext context,
    required int success,
    required String message}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        dismissDirection: DismissDirection.horizontal,
        
        duration: const Duration(seconds: 2),
        margin: EdgeInsets.symmetric(vertical: 4.w, horizontal: 4.w),
        backgroundColor: success == 0
            ? Colors.red
            : success == 1
                ? Colors.green
                : Colors.orange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        behavior: SnackBarBehavior.floating,
        content: ElasticIn(
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.secondTitle.copyWith(),
          ),
        )),
  );
}
