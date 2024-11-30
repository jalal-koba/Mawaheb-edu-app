import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Apis/urls.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Lessons/Models/file_model.dart';
import 'package:talents/Modules/Widgets/custom_button.dart';

class AttachedFile extends StatelessWidget {
  const AttachedFile({
    required this.file,
    super.key,
  });

  final FileModel file;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15.h,
      width: 42.w,
      margin: EdgeInsets.symmetric(horizontal: 1.w),
      padding: EdgeInsets.all(1.5.w),
      decoration: BoxDecoration( 
          color: AppColors.cardBackground,
          boxShadow: boxShadow,
          border: const Border(
              bottom: BorderSide(
            width: 2,
            color: AppColors.secondary,
          )),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            file.name,
            style:
                AppTextStyles.secondTitle.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          CustomButton(
              width: 27,
              height: 3.6,
              fontSize: 9,
              titlebutton: "فتح الملف",
              onPressed: () {
                EasyLauncher.url(url: "${Urls.storageBaseUrl}${file.path}");
              })
        ],
      ),
    );
  }
}
