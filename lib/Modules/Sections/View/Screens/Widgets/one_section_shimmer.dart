import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Modules/Courses/View/Widgets/shimmer_course_card.dart';
import 'package:talents/Modules/Widgets/description_shimmer.dart';

class OneSectionShimmer extends StatelessWidget {
  const OneSectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 3.h,
              ),
           const   DescriptionShimmer(
                linesNumber: 4,
              ),
              SizedBox(height: 2.5.h),
              Text(
                'الكورسات',
                style: AppTextStyles.meduimTitle
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          sliver: SliverList.builder(
              itemCount: 5,
              itemBuilder: (context, index) => ShimmerCourseCard(index: index)),
        )
      ],
    );
  }
}
