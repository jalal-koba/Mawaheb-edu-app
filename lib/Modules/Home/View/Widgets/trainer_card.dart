import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Trainers/Model/trainer.dart';
import 'package:talents/Modules/Trainers/View/Screens/trainer_info_screen.dart';
import 'package:talents/Modules/Widgets/cached_image.dart';

class TrainerCard extends StatelessWidget {
  const TrainerCard({
    super.key,
    required this.isHome,
    required this.trainer,
  });

  final bool isHome;
  final Trainer trainer;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        pushTo(
            context: context,
            toPage: TrainerInfoScreen(
              name: trainer.fullName,
              id: trainer.id,
            ));
      },
      child: Container(
        width: 44.w,
        margin: isHome
            ? EdgeInsets.symmetric(horizontal: 4.w)
            : EdgeInsets.all(
                1.5.w,
              ),
        padding: EdgeInsets.all(1.w),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          border: const Border(
              bottom: BorderSide(color: AppColors.secondary, width: 2)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              offset: const Offset(0, 5), //
              blurRadius: 10,
              spreadRadius: 1,
            )
          ],
          borderRadius: BorderRadius.circular(20),
          // border: Border.all(width: 1, color: AppColors.primary)
        ),
        height: 28.h,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (!isHome) SizedBox(height: 0.5.h),
            Container(
              width: isHome ? 21.w : 25.w,
              height: isHome ? 10.h : 12.h,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
              child: trainer.image != null
                  ? CachedImage(
                      imageUrl: trainer.image!,
                    )
                  : Icon(
                      Icons.person,
                      color: AppColors.primary,
                      size: 25.w,
                    ),
            ),
            SizedBox(
              width: 3.5.w,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(height: 1.h),
                  Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    trainer.fullName,
                    style: AppTextStyles.secondTitle
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 12.sp),
                  ),
                  if (trainer.description != null)
                    Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        trainer.description!,
                        style: AppTextStyles.secondTitle),
                  SizedBox(height: 0.9.h),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
