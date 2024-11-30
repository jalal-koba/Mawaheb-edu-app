import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Modules/Notifications/cubit/notifications_cubit.dart';

class NotificationsIcon extends StatelessWidget {
  const NotificationsIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final int num = context.watch<NotificationsCubit>().unreadNotifications;
    if (num == 0) {
      return const SizedBox();
    }
    return Positioned(
      top: 5,
      right: 5,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            // shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(20),
            color: Colors.red.withOpacity(0.9)),
        child: Text(
          textAlign: TextAlign.center,
          num < 100 ? "$num" : "+99",
          style: AppTextStyles.meduimTitle
              .copyWith(fontSize: 6.sp, color: Colors.white),
        ),
      ),
    );
  }
}
