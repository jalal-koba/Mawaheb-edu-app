import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/images.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Lessons/Models/lesson.dart';
import 'package:talents/Modules/Widgets/cached_image.dart';

class LessonCard extends StatelessWidget {
  const LessonCard({
    super.key,
    required this.lesson,
  });
  final Lesson lesson;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 2,
            ),
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
                      imageUrl: lesson.coverImage,
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
                    lesson.name,
                    style: AppTextStyles.secondTitle.copyWith(
                        color: Colors.white,
                        fontSize: 9.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          if (lesson.isFree)
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 1),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.red.shade200,
                    offset: const Offset(0, 0.5),
                    blurRadius: 1.5,
                    spreadRadius: 1,
                  )
                ]),
                child: Text(
                  "مجاني",
                  style: AppTextStyles.secondTitle
                      .copyWith(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          if (!lesson.isOpen)
            Container(
                decoration: BoxDecoration(
                    boxShadow: boxShadow,
                    color: Colors.white,
                    shape: BoxShape.circle),
                child: SvgPicture.asset(
                  Images.lessonLock,
                  width: 40.sp,
                )),
        ],
      );
    });
  }
}
