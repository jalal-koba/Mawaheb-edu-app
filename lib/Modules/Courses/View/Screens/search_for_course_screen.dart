import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/images.dart';
import 'package:talents/Modules/Courses/Cubit/Cubit/course_cubit.dart';
import 'package:talents/Modules/Courses/Cubit/States/course_state.dart';
import 'package:talents/Modules/Courses/View/Widgets/course_card.dart';
import 'package:talents/Modules/Courses/View/Widgets/search_loading_shimmer.dart';
import 'package:talents/Modules/Widgets/app_footer.dart';
import 'package:talents/Modules/Widgets/custom_field.dart';
import 'package:talents/Modules/Widgets/refresher_header.dart';
import 'package:talents/Modules/Widgets/try_agin.dart';
import '../../../Widgets/app_scaffold.dart';

class SearchForCourseScreen extends StatelessWidget {
  SearchForCourseScreen({super.key});
  final CourseCubit oneCourseCubit = CourseCubit();
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "البحث عن كورس",
      body: BlocProvider(
        create: (context) => oneCourseCubit..searchForCourse(text: ""),
        child: BlocBuilder<CourseCubit, CourseState>(
          builder: (context, state) {
            final CourseCubit oneCourseCubit = CourseCubit.get(context);
            return SmartRefresher(
              enablePullDown: state is SearchCourseSuccess,
              enablePullUp: state is SearchCourseSuccess,
              footer: const AppFooter(
                title: 'لا يوجد المزيد من الكورسات',
              ),
              header: const AppRefresherHeader(),
              onLoading: () {
                oneCourseCubit.searchForCourse(
                    text: oneCourseCubit.searchFieldController.text);
              },
              onRefresh: () async {
                oneCourseCubit.page = 1;
                await oneCourseCubit.searchForCourse(
                    text: oneCourseCubit.searchFieldController.text);

                oneCourseCubit.refreshController.refreshCompleted();
                oneCourseCubit.refreshController.loadComplete();
              },
              controller: oneCourseCubit.refreshController,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                        color: AppColors.cardBackground,
                        width: 100.w,
                        height: 4.h),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverAppBarDelegate(
                      minHeight: 7.h,
                      maxHeight: 9.h,
                      child: Container(
                        color: AppColors.cardBackground,
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 1.h),
                        child: CustomTextField(
                            onEditingComplete: () {
                              oneCourseCubit.page = 1;

                              oneCourseCubit.searchForCourse(
                                  text: oneCourseCubit
                                      .searchFieldController.text);
                            },
                            prefixIcon: IconButton(
                              icon: const Icon(
                                Icons.search,
                                color: AppColors.primary,
                              ),
                              onPressed: () {
                                oneCourseCubit.page = 1;
                                if (oneCourseCubit
                                        .searchFieldController.text.isEmpty ||
                                    state is SearchCourseLoading) {
                                  return;
                                }
                                oneCourseCubit.searchForCourse(
                                    text: oneCourseCubit
                                        .searchFieldController.text);
                              },
                            ),
                            textInputAction: TextInputAction.search,
                            onChanged: (valueToSearch) {
                              oneCourseCubit.page = 1;
                              oneCourseCubit.refreshController.loadComplete();
                              oneCourseCubit.searchForCourse(
                                  text: valueToSearch);
                            },
                            controller: oneCourseCubit.searchFieldController,
                            keyboardtype: TextInputType.name,
                            label: "أدخل اسم الكورس الذي تبحث عنه..."),
                      ),
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      if (state is SearchCourseError) {
                        return SliverList.list(
                          children: [
                            TryAgain(
                                message: state.message,
                                onTap: () {
                                  oneCourseCubit.searchForCourse(
                                      text: oneCourseCubit
                                          .searchFieldController.text);
                                }),
                          ],
                        );
                      }

                      if (state is SearchCourseLoading) {
                        return SliverPadding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 1.h),
                          sliver: const SearchLoadingShimmer(
                            count: 6,
                          ),
                        );
                      }

                      if (oneCourseCubit.courses.isEmpty) {
                        return SliverList.list(
                          children: [
                            SizedBox(width: 0.0, height: 10.h),
                            Image.asset(
                              Images.noData,
                              height: 35.h,
                            ),
                            const SizedBox(
                              width: double.infinity,
                            ),
                            Center(
                              child: Text(
                                'لا يوجد بيانات !',
                                style: AppTextStyles.meduimTitle
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        );
                      }
                      return SliverPadding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 1.h),
                        sliver: SliverList.builder(
                          itemCount: oneCourseCubit.courses.length,
                          itemBuilder: (context, index) => CourseCard(
                            callback: () {
                              oneCourseCubit.searchForCourse(
                                  text: oneCourseCubit
                                      .searchFieldController.text);
                            },
                            index: index,
                            tag: "courseInfo$index",
                            course: oneCourseCubit.courses[index],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
