import 'package:flutter/material.dart'; 
import 'package:talents/Modules/Courses/View/Widgets/shimmer_course_card.dart';

class SearchLoadingShimmer extends StatelessWidget {
  const SearchLoadingShimmer({
    super.key, required this.count,
  });
final  int count;
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 6,
      itemBuilder: (context, index) => ShimmerCourseCard(
        index: index,
      ),
    );
  }
}
