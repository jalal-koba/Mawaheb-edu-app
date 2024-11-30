import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Widgets/page_loading.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return CustomFooter(builder: (context, mode) {
      if (mode == LoadStatus.noMore) {
        return Center(
          child: Padding(
            padding: EdgeInsets.only(top: 1.h),
            child: FadeIn(
              child: Text(
                title,
                style: AppTextStyles.meduimTitle.copyWith(shadows: boxShadow),
              ),
            ),
          ),
        );
      }

      return const PageLoading();
    });
  }
}
