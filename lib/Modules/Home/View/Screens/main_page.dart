import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/images.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Helper/app_sharedPreferance.dart';
import 'package:talents/Modules/Courses/View/Screens/search_for_course_screen.dart';
import 'package:talents/Modules/Home/Cubit/cubit/main_page_cubit.dart';
import 'package:talents/Modules/Home/Cubit/state/main_page_stata.dart';
import 'package:talents/Modules/Notifications/View/Widgets/notifications_icon.dart';
import 'package:talents/Modules/Notifications/View/notification_screen.dart';
import 'package:talents/Modules/Notifications/cubit/notifications_cubit.dart';
import 'package:talents/Modules/Auth/Cubit/profile_cubit.dart';
import 'package:talents/Modules/Widgets/app_drawer.dart';
import 'package:talents/Modules/Widgets/drawer_without_login.dart';

import '../Widgets/app_logo_with_cliper.dart';
import '../Widgets/bottom_nav_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MianPageState();
}

class _MianPageState extends State<MainPage> {
  @override
  void initState() {
    if (AppSharedPreferences.hasToken) {
      context.read<ProfileCubit>().getProfileInfo();
    }
    

    super.initState();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      bottomNavigationBar: const BottomNavBar(),
      appBar: AppBar(
        foregroundColor: const Color.fromARGB(255, 0, 72, 139),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: IconButton(
              onPressed: () {
                pushTo(context: context, toPage: SearchForCourseScreen());
              },
              icon: const Icon(Icons.search),
            ),
          )
        ],
        titleSpacing: 0,
        leadingWidth: (AppSharedPreferences.hasToken) ? 50.w : null,
        leading: (AppSharedPreferences.hasToken)
            ? Row(
                children: [
                  IconButton(
                      onPressed: () {
                        _key.currentState?.openDrawer();
                      },
                      icon: const Icon(Icons.menu)),
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      IconButton(
                          onPressed: () async {
                            final NotificationsCubit notificationsCubit =
                                context.read<NotificationsCubit>();

                            await pushTo(
                                context: context, toPage: const NotificationScreen());

                            notificationsCubit.makeUnreadZero();
                          },
                          icon: const Icon(Icons.notifications_none_rounded)),
                      const NotificationsIcon()
                    ],
                  ),
                ],
              )
            : null,
      ),
      drawer: AppSharedPreferences.hasToken
          ? appDrawer(context)
          : appDrawerWithoutLogin(context),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Images.appBack), fit: BoxFit.fill)),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BlocBuilder<MainPageCubit, MainPageState>(
                  builder: (context, state) {
                    final mainPageCubit = MainPageCubit.get(context);
                    return Expanded(
                      child: mainPageCubit.pages[mainPageCubit.selectedPage],
                    );
                  },
                ),
              ],
            ),
            const AppLogoWithCliper(),
          ],
        ),
      ),
    );
  }
}
