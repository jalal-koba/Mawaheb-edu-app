import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Modules/Notifications/Models/notification.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.notification,
  });
  final AppNotification notification;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 17.h,
          width: 100.w,
          padding: EdgeInsets.all(2.w),
          margin: EdgeInsets.symmetric(
            vertical: 1.h,
          ),
          decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(12),
              border: const Border(
                  bottom: BorderSide(color: AppColors.primary, width: 2))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(notification.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.meduimTitle
                      .copyWith(fontSize: 12.sp, fontWeight: FontWeight.bold)),
              Text(notification.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.secondTitle),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Text(notification.date,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.secondTitle.copyWith(fontSize: 10.sp)),
              ),
            ],
          ),
        ),
        if (!notification.hasRead)
          Container(
            height: 2.h,
            width: 2.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
          )
      ],
    );
  }
}
