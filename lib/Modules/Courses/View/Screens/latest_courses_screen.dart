import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Modules/Courses/Cubit/Cubit/course_cubit.dart';
import 'package:talents/Modules/Courses/Cubit/States/course_state.dart';
import 'package:talents/Modules/Courses/View/Widgets/course_card.dart';
import 'package:talents/Modules/Widgets/app_footer.dart';
import 'package:talents/Modules/Widgets/app_loading.dart';
import 'package:talents/Modules/Widgets/refresher_header.dart';
import 'package:talents/Modules/Widgets/try_agin.dart';

import '../../../Widgets/app_scaffold.dart';

class LatestCoursesScreen extends StatelessWidget {
  const LatestCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "الكورسات الضافة أخيراً",
      body: BlocProvider(
        create: (context) => CourseCubit()..getLatestCourses(),
        child: BlocBuilder<CourseCubit, CourseState>(
          builder: (context, state) {
            final CourseCubit courseCubit = CourseCubit.get(context);

            if (state is LatestCoursesLoadingState) {
              return const AppLoading();
            }
            if (state is LatestCoursesErrorState) {
              return TryAgain(
                  onTap: () {
                    courseCubit.getLatestCourses();
                  },
                  message: state.message);
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
                courseCubit.getLatestCourses();
              },
              onLoading: () {
                courseCubit.getLatestCourses();
              },
              child: ListView.builder(
                  padding:
                      EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                  itemCount: courseCubit.latestCourses.length,
                  itemBuilder: (context, index) => CourseCard(
                      callback: () {
                        courseCubit.getLatestCourses();
                      },
                      index: index,
                      tag: "courseInfo1$index",
                      course: courseCubit.latestCourses[index])),
            );
          },
        ),
      ),
    );
  }
}
