import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Modules/Courses/View/Widgets/course_card.dart';
import 'package:talents/Modules/Payments_Orders/Model/section.dart';
import 'package:talents/Modules/Sections/Cubit/sections_cubit.dart';
import 'package:talents/Modules/Sections/Cubit/sections_state.dart';
import 'package:talents/Modules/Sections/View/Screens/Widgets/one_section_shimmer.dart';
import 'package:talents/Modules/Widgets/app_footer.dart';
import 'package:talents/Modules/Widgets/refresher_header.dart';
import 'package:talents/Modules/Widgets/try_agin.dart';
import '../../../Widgets/app_scaffold.dart';

class OneSectionScreen extends StatelessWidget {
  const OneSectionScreen({
    super.key,
    required this.section,
  });
  final Section section;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        title: section.name,
        body: BlocProvider(
          create: (context) =>
              SectionsCubit()..getOneSectionInfo(perantId: section.id),
          child: Builder(builder: (context) {
            final state = context.watch<SectionsCubit>().state;
            final SectionsCubit sectionsCubit = SectionsCubit.get(context);

            if (state is SectionsErrorState) {
              return TryAgain(
                  message: state.message,
                  onTap: () {
                    sectionsCubit.getOneSectionInfo(perantId: section.id);
                  });
            }

            if (state is OneSectionLoadingState) {
              return const OneSectionShimmer();
            }

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: SmartRefresher(
                enablePullUp: true,
                onRefresh: () async {
                  sectionsCubit.page = 1;
                  await sectionsCubit.getOneSectionInfo(perantId: section.id);
                  sectionsCubit.refreshController.refreshCompleted();
                  sectionsCubit.refreshController.loadComplete();
                },
                footer: const AppFooter(
                  title: 'لا يوجد المزيد من الكورسات',
                ),
                onLoading: () {
                  sectionsCubit.getOneSectionInfo(perantId: section.id);
                },
                header: const AppRefresherHeader(),
                controller: sectionsCubit.refreshController,
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 3.h,
                          ),
                          Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Text(
                                textAlign: TextAlign.start,
                                style: AppTextStyles.explanatoryText,
                                sectionsCubit.description),
                          ),
                          SizedBox(height: 2.5.h),
                          Text(
                            'الكورسات',
                            style: AppTextStyles.meduimTitle
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 2.h),
                        ],
                      ),
                    ),
                    SliverList.builder(
                      itemCount: sectionsCubit.course.length,
                      itemBuilder: (context, index) => CourseCard(
                        callback: () {
                          sectionsCubit.getOneSectionInfo(perantId: section.id);
                        },
                        index: index,
                        course: sectionsCubit.course[index],
                        tag: "Sections$index",
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        ));
  }
}
