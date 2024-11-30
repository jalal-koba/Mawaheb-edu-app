import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Modules/Notifications/View/Widgets/notification_card.dart';
import 'package:talents/Modules/Notifications/cubit/notifications_cubit.dart';
import 'package:talents/Modules/Widgets/app_footer.dart';
import 'package:talents/Modules/Widgets/app_loading.dart';
import 'package:talents/Modules/Widgets/app_scaffold.dart';
import 'package:talents/Modules/Widgets/no_data.dart';
import 'package:talents/Modules/Widgets/refresher_header.dart';
import 'package:talents/Modules/Widgets/try_agin.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<NotificationsCubit>().page = 1;
    context.read<NotificationsCubit>().getNotifications(markRead: 1);
    return AppScaffold(
        title: "الإشعارات",
        body: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            final NotificationsCubit notificationsCubit =
                NotificationsCubit.get(context);

            if (state is NotificationsErrorState) {
              return TryAgain(
                  onTap: () {
                    notificationsCubit.getNotifications(markRead: 1);
                  },
                  message: state.message);
            }

            if (state is NotificationsLoadingState) {
              return const AppLoading();
            }

            if (notificationsCubit.notifications.isEmpty) {
              return const Nodata();
            }
            notificationsCubit.makeUnreadZero();
            return SmartRefresher(
              controller: notificationsCubit.refreshController,
              enablePullDown: true,
              enablePullUp: true,
              header: const AppRefresherHeader(),
              footer: const AppFooter(
                title: 'لا يوجد المزيد من الإشعارات',
              ),
              onRefresh: () async {
                notificationsCubit.page = 1;
                await notificationsCubit.getNotifications(markRead: 1);
                notificationsCubit.refreshController.loadComplete();
              },
              onLoading: () {
                notificationsCubit.getNotifications(markRead: 1);
              },
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  itemCount: notificationsCubit.notifications.length,
                  itemBuilder: (context, index) => InkWell(
                        onTap: () {},
                        child: NotificationCard(
                          notification: notificationsCubit.notifications[index],
                        ),
                      )),
            );
          },
        ));
  }
}
