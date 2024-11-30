import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Modules/Widgets/app_shimmer.dart';

class DescriptionShimmer extends StatelessWidget {
  const DescriptionShimmer({
    super.key,
    required this.linesNumber,
  });
  final int linesNumber;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          linesNumber,
          (index) => AppShimmer(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 1.h),
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(2)),
              height: 10,
              width: 100.w - (index * 20.w),
            ),
          ),
        ),
      ),
    );
  }
}
