import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Modules/Courses/View/Widgets/course_card.dart';
import 'package:talents/Modules/Widgets/app_shimmer.dart';

class ShimmerCourseCard extends StatelessWidget {
  const ShimmerCourseCard({
    super.key,
    required this.index,
  });
  final int index;
  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: Duration(milliseconds: 300 + 150 * (index % 3)),
      child: CardWithShadow(
        height: 20.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppShimmer(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(2)),
                      child: SizedBox(
                        width: 40.w,
                        height: 2.h,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        AppShimmer(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(2)),
                            width: 30.w,
                            height: 2.h,
                          ),
                        ),
                        AppShimmer(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(2)),
                            width: 30.w,
                            height: 2.h,
                          ),
                        ),
                        AppShimmer(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(2)),
                            width: 30.w,
                            height: 2.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              clipBehavior: Clip.hardEdge,
              margin: EdgeInsets.all(1.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: const Border(
                  bottom: BorderSide(color: AppColors.primary, width: 1.5),
                ),
              ),
              child: AppShimmer(
                child: Container(
                  color: Colors.grey,
                  width: 30.w,
                  height: 15.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
