import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';

class ViewAll extends StatelessWidget {
  const ViewAll(
      {super.key,
      required this.text,
      this.tag,
      required this.onPressed,
      this.buttonText = "عرض الكل"});
  final String text, buttonText;
  final String? tag;

  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Row(
        children: <Widget>[
          SizedBox(width: 65.w,
            child: Text(
              text,
              style: AppTextStyles.meduimTitle
                  .copyWith(fontWeight: FontWeight.w900, fontSize: 13.sp),
            ),
          ),
          const Spacer(),
          TextButton(
              onPressed: onPressed,
              child: Row(
                children: [
                  Text(
                    "عرض الكل",
                    style: AppTextStyles.secondTitle.copyWith(color: AppColors.primary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(width: 2.w,  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 12.sp,
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
