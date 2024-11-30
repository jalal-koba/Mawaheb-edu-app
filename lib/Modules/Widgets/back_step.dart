import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_text_styles.dart';

class BackStep extends StatelessWidget {
  const BackStep({
    super.key,
    required this.title,
    this.fontSize = 14,
  });
  final String title;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        FadeIn(
          child: SizedBox(
            width: 78.w,
            child: Text(maxLines: 2,
            overflow: TextOverflow.ellipsis,
               title ,
              style: AppTextStyles.meduimTitle
                  .copyWith(fontWeight: FontWeight.bold, fontSize: fontSize.sp),
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
