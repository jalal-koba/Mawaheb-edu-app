import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Modules/Courses/Cubit/Cubit/course_cubit.dart';
import 'package:talents/Modules/Courses/Cubit/States/course_state.dart';
import 'package:talents/Modules/Courses/View/Widgets/course_card.dart';
import 'package:talents/Modules/Courses/View/Widgets/subscribed_course_shemmer.dart';
import 'package:talents/Modules/Widgets/app_footer.dart';
import 'package:talents/Modules/Widgets/no_data.dart';
import 'package:talents/Modules/Widgets/refresher_header.dart';
import 'package:talents/Modules/Widgets/try_agin.dart';

import '../../../Widgets/app_scaffold.dart';

class SubscribedCoursesScreen extends StatelessWidget {
  const SubscribedCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "الكورسات المشترك بها",
      body: BlocProvider(
        create: (context) => CourseCubit()..getSubscribedCourses(),
        child: BlocBuilder<CourseCubit, CourseState>(
          builder: (context, state) {
            final CourseCubit courseCubit = CourseCubit.get(context);

            if (state is SubscribedCourseLoadingState) {
              return const SubscribedCourseShemmer(
                count: 6,
              );
            }
            if (state is SubscribedCourseErrorState) {
              return TryAgain(
                message: state.message,
                onTap: () {
                  courseCubit.getSubscribedCourses();
                },
              );
            }

            if (courseCubit.subscribedCourses.isEmpty) {
              return const Nodata();
            }
            return SmartRefresher(
              footer: const AppFooter(
                title: 'لا يوجد المزيد من الكورسات',
              ),
              header: const AppRefresherHeader(),
              controller: courseCubit.refreshController,
              enablePullUp: true,
              enablePullDown: true,
              onRefresh: () {
                courseCubit.page = 1;
                courseCubit.refreshController.loadComplete();
                courseCubit.getSubscribedCourses();
              },
              onLoading: () {
                courseCubit.getSubscribedCourses();
              },
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  itemCount: courseCubit.subscribedCourses.length,
                  itemBuilder: (context, index) {
                    courseCubit.subscribedCourses[index].subscribed = true;
                    return CourseCard(
                      callback: () {},
                      index: index,
                      tag: "courseInfo2$index",
                      course: courseCubit.subscribedCourses[index],
                    );
                  }),
            );
          },
        ),
      ),
    );
  }
}
