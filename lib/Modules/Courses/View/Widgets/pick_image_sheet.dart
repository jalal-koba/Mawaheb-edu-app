import 'package:flutter/material.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';

Future<void> pickImageSheet(
    {required void Function() onTapGallery,
    required void Function() onTapCamera,
    required BuildContext context}) async {
  showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(
                    Icons.photo_library,
                    color: AppColors.primary,
                  ),
                  title: Text(
                    'اختر من المعرض',
                    style: AppTextStyles.meduimTitle
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  onTap: onTapGallery),
              ListTile(
                  leading: const Icon(
                    Icons.photo_camera,
                    color: AppColors.primary,
                  ),
                  title: Text('التقط صورة',
                      style: AppTextStyles.meduimTitle
                          .copyWith(fontWeight: FontWeight.w500)),
                  onTap: onTapCamera),
            ],
          ),
        );
      });
}
