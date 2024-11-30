import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Trainers/Model/trainer.dart'; 
import 'package:talents/Modules/Trainers/View/Screens/trainer_info_screen.dart';
import 'package:talents/Modules/Widgets/cached_image.dart';

class TrainerInCourse extends StatelessWidget {
  const TrainerInCourse({
    super.key,
    required this.trainer,
  });

  final Trainer trainer;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92.w,
      margin: EdgeInsets.only(bottom: 1.5.h),
      decoration: BoxDecoration(
        border: const Border(
            bottom: BorderSide(color: AppColors.secondary, width: 1)),
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        onTap: () {
          pushTo(
              context: context,
              toPage: TrainerInfoScreen(
                name: trainer.fullName,
                id: trainer.id,
              ));
        },
        title: Text(
          trainer.fullName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.secondTitle,
        ),
        minTileHeight: 10.h,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        tileColor: Colors.white,
        leading: Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary, width: 0.5),
                shape: BoxShape.circle),
            child: Container(
                width: 20.w,
                height: 20.w,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: boxShadow,
                    color: Colors.white),
                child: CachedImage(isPerson: true, imageUrl: trainer.image))),
        // trailing: Text(
        //   'عرض',
        //   style: AppTextStyles.meduimTitle.copyWith(
        //       color: AppColors.primary,
        //       decorationColor: AppColors.primary,
        //       decoration: TextDecoration.underline),
        // ),
      ),
    );
  }
}
