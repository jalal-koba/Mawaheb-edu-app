import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart'; 
import 'package:talents/Modules/Courses/View/Widgets/shimmer_course_card.dart';

class SubscribedCourseShemmer extends StatelessWidget {
  const SubscribedCourseShemmer({
    super.key, required this.count,
  });
final  int count;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),

      itemCount: 6,
      itemBuilder: (context, index) => ShimmerCourseCard(
        index: index,
      ),
    );
  }
}
