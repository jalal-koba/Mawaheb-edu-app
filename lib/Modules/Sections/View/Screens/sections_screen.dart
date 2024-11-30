import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Library/View/Widgets/grad_shimmer.dart';
import 'package:talents/Modules/Sections/Cubit/sections_cubit.dart';
import 'package:talents/Modules/Sections/Cubit/sections_state.dart';
import 'package:talents/Modules/Sections/View/Screens/one_section_screen.dart';
import 'package:talents/Modules/Widgets/app_footer.dart';
import 'package:talents/Modules/Widgets/app_scaffold.dart';
import 'package:talents/Modules/Widgets/section_card.dart';
import 'package:talents/Modules/Widgets/no_data.dart';
import 'package:talents/Modules/Widgets/refresher_header.dart';
import 'package:talents/Modules/Widgets/try_agin.dart';

class SectionsScreen extends StatelessWidget {
  SectionsScreen({super.key});

  final SectionsCubit sectionsCubit = SectionsCubit();
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "الأقسام",
      body: BlocProvider(
        create: (context) => sectionsCubit..getSections(),
        child: BlocBuilder<SectionsCubit, SectionsState>(
            builder: (context, state) {
          final SectionsCubit sectionsCubit = SectionsCubit.get(context);
          if (state is SectionsErrorState) {
            return TryAgain(
              message: state.message,
              onTap: () => sectionsCubit.getSections(),
            );
          }
          if (state is SectionsLoadingState) {
            return const GradShimmer(
              isScrollable: true,
            );
          }

          if (sectionsCubit.sections.isEmpty) {
            return const Nodata();
          }
          return SmartRefresher(
            controller: sectionsCubit.refreshController,
            header: const AppRefresherHeader(),
            footer: const AppFooter(
              title: 'لا يوجد المزيد من الأقسام',
            ),
            enablePullDown: true,
            enablePullUp: true,
            onLoading: () {
              sectionsCubit.getSections();
            },
            onRefresh: () {
              sectionsCubit.page = 1;
              sectionsCubit.getSections();
              sectionsCubit.refreshController.refreshCompleted();
              sectionsCubit.refreshController.loadComplete();
            },
            child: GridView.builder(
              padding:
                  EdgeInsets.only(left: 2.w, right: 2.w, top: 2.h, bottom: 5.h),
              itemCount: context.watch<SectionsCubit>().sections.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.1,
                  crossAxisCount: 2,
                  mainAxisSpacing: 1.h),
              itemBuilder: (context, index) => InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  pushTo(
                      context: context,
                      toPage: OneSectionScreen(
                        section: sectionsCubit.sections[index],
                      ));
                },
                child: SectionCard(section: sectionsCubit.sections[index]),
              ),
            ),
          );
        }),
      ),
    );
  }
}
