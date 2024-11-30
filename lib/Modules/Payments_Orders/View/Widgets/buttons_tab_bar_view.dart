import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';

class ButtonsTabBarView extends StatelessWidget {
  const ButtonsTabBarView({
    super.key,
    required this.tabController,
    this.tabBarTitles = const [
      "الكل",
      "الموافق عليها",
      "قيد الانتظار",
      "الملغاة"
    ],
  });
  final TabController tabController;

  final List tabBarTitles;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 9.h,
      child: TabBar(
        dividerColor: AppColors.secondary,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: AppColors.primary,
        labelColor: AppColors.primary,
        labelStyle:
            AppTextStyles.secondTitle.copyWith(fontWeight: FontWeight.bold),
        unselectedLabelStyle: AppTextStyles.secondTitle,
        onTap: (value) {},
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        indicatorPadding: EdgeInsets.symmetric(vertical: 1.6.h),
        indicator: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: AppColors.primary, width: 1))),
        labelPadding: const EdgeInsets.all(0),
        tabs: [
          ...List.generate(
            tabController.length,
            (index) => Tab(
              height: 7.h,
              child: ElasticIn(
                child: Container(
                    height: 7.h,
                    width: index == 1 ? 24.w : 22.5.w,
                    padding: const EdgeInsets.all(1),
                    alignment: Alignment.center,
                    child: Text(
                      textAlign: TextAlign.center,
                      tabBarTitles[index],
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}


/*



                  */