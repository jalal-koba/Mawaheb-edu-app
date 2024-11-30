import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Payments_Orders/Model/section.dart';
import 'package:talents/Modules/Sections/View/Screens/one_section_screen.dart';
import 'package:talents/Modules/Widgets/cached_image.dart';

class SectionCard extends StatelessWidget {
  const SectionCard({
    super.key,
    required this.section,
  });
  final Section section;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return InkWell(
        onTap: () {
          pushTo(
              context: context,
              toPage: OneSectionScreen(
                section: section,
              ));
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 2, horizontal: 3.w),
          height: constraints.maxHeight,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
              boxShadow: boxShadow,
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: SizedBox(
                  width: constraints.maxWidth + 100,
                  height: constraints.maxHeight - 4.h - 4,
                  child: CachedImage(
                    imageUrl: section.image,
                  ),
                ),
              ),
              Container(
                height: 4.h,
                padding: const EdgeInsets.only(bottom: 2, right: 1, left: 1),
                decoration: const BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                alignment: Alignment.center,
                width: constraints.maxWidth + 100,
                child: Text(
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  section.name,
                  style: AppTextStyles.secondTitle.copyWith(
                      color: Colors.white,
                      fontSize: 9.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
