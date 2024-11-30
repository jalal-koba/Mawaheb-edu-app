import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Widgets/description_shimmer.dart';
import 'package:talents/Modules/Widgets/shimmer_card.dart';

class LessonShimmer extends StatelessWidget {
  const LessonShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: 2.h),
      children: [
        SizedBox(height: 3.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DescriptionShimmer(linesNumber: 2),
              SizedBox(height: 1.h),
              ShimmerCard(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  height: 25.h,
                  width: 100.w,
                  borderRadius: BorderRadius.circular(10)),
              SizedBox(height: 2.5.h),
              const DescriptionShimmer(linesNumber: 4),
              SizedBox(height: 2.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Text(
                      'الملفات المرفقة',
                      style: AppTextStyles.meduimTitle
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  SizedBox(
                    height: 16.h,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) =>
                            const Align(child: AttachedFileShimmer())),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AttachedFileShimmer extends StatelessWidget {
  const AttachedFileShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15.h,
      width: 42.w,
      margin: EdgeInsets.symmetric(horizontal: 1.w),
      // padding: EdgeInsets.all(1.5.w),
      decoration: BoxDecoration(
          color: AppColors.cardBackground,
          boxShadow: boxShadow,
          border: const Border(
              bottom: BorderSide(
            width: 2,
            color: AppColors.primary,
          )),
          borderRadius: BorderRadius.circular(10)),
      child: const DescriptionShimmer(linesNumber: 3),
    );
  }
}
