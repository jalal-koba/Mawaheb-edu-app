import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Courses/View/Screens/latest_courses_screen.dart';
import 'package:talents/Modules/Library/View/Widgets/home_library_shimmer.dart';
import 'package:talents/Modules/Sections/View/Widgets/carousal_carousal_sections_shimmer.dart';
import 'package:talents/Modules/Trainers/View/Screens/trainers_screen.dart';
import 'package:talents/Modules/Home/Cubit/cubit/home_cubit.dart';
import 'package:talents/Modules/Home/Cubit/cubit/main_page_cubit.dart';
import 'package:talents/Modules/Home/Cubit/state/home_state.dart';
import 'package:talents/Modules/Offers/View/offers_screen.dart';
import 'package:talents/Modules/Courses/View/Widgets/course_card.dart';
import 'package:talents/Modules/Home/View/Widgets/trainer_card.dart';
import 'package:talents/Modules/Offers/View/Widgets/offers_carousal.dart';
import 'package:talents/Modules/Sections/View/Widgets/sections_carousal.dart';
import 'package:talents/Modules/Home/View/Widgets/shimmers/carousal_offers_shimmer.dart';
import 'package:talents/Modules/Home/View/Widgets/view_all.dart';
import 'package:talents/Modules/Sections/View/Screens/sections_screen.dart';
import 'package:talents/Modules/Widgets/cached_image.dart';
import 'package:talents/Modules/Widgets/try_agin.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SlideInUp(
      child: BlocProvider(
        create: (context) => HomeCubit()..getHomeInfo(),
        child: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
          final HomeCubit homeCubit = HomeCubit.get(context);

          if (state is HomeErrorState) {
            return TryAgain(
                message: state.message,
                onTap: () {
                  homeCubit.getHomeInfo();
                });
          }

          return Theme(
            data: ThemeData(
                colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primary,
            )),
            child: SmartRefresher(
              physics: const BouncingScrollPhysics(),
              controller: homeCubit.refreshController,
              enablePullDown: true,
              onRefresh: () async {
                await homeCubit.getHomeInfo();
                homeCubit.refreshController.refreshCompleted();
              },
              child: ListView(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    SizedBox(height: 16.h),
                    OffersLayer(
                      homeCubit: homeCubit,
                    ),
                    SectionsLayer(
                      homeCubit: homeCubit,
                    ),
                    _LibraryLayer(homeCubit: homeCubit),
                    TrainersLayer(homeCubit: homeCubit),
                    _LatestCoursesLayer(homeCubit: homeCubit)
                  ]),
            ),
          );
        }),
      ),
    );
  }
}

class _LatestCoursesLayer extends StatelessWidget {
  const _LatestCoursesLayer({
    required this.homeCubit,
  });

  final HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    if (homeCubit.state is HomeLoadingState) {
      return SizedBox(height: 8.h);
    }
    if (homeCubit.latestCourses.isNotEmpty) {
      return Column(
        children: [
          ViewAll(
              text: "الكورسات المضافة أخيراً",
              onPressed: () {
                pushTo(context: context, toPage: const LatestCoursesScreen());
              }),
          SizedBox(height: 2.h),
          ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: homeCubit.latestCourses.length,
            itemBuilder: (context, index) => CourseCard(
              callback: () {
                homeCubit.getHomeInfo();
              },
              index: index,
              tag: "courseInfo3$index",
              course: homeCubit.latestCourses[index],
            ),
          ),
          SizedBox(height: 8.h),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}

class TrainersLayer extends StatelessWidget {
  const TrainersLayer({
    super.key,
    required this.homeCubit,
  });

  final HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    if (homeCubit.state is HomeLoadingState) {
      return const SizedBox();
    }
     
    if (homeCubit.trainers.isNotEmpty) {
      return Column(
        children: [
          ViewAll(
              text: "المدربين",
              onPressed: () {
                pushTo(context: context, toPage: TrainersScreen());
              }),
          // SizedBox(height: 2.h),
          Container(
            alignment: Alignment.topCenter,
            height: 33.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: homeCubit.trainers.length,
              itemBuilder: (context, index) => Align(
                alignment: Alignment.center,
                child: TrainerCard(
                    isHome: true, trainer: homeCubit.trainers[index]),
              ),
            ),
          ),
          SizedBox(height: 3.h),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}

class _LibraryLayer extends StatelessWidget {
  const _LibraryLayer({
    required this.homeCubit,
  });

  final HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ViewAll(
          text: "مكتبة التطبيق",
          buttonText: "عرض المكتبة",
          onPressed: () {
            context.read<MainPageCubit>().moveTab(1);
          },
        ),
        SizedBox(height: 2.h),
        if (homeCubit.libraryImage != null ||
            homeCubit.state is HomeLoadingState)
          Builder(
            builder: (context) {
              if (homeCubit.state is HomeLoadingState) {
                return const HomeLibraryShimmer();
              }
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 22.h,
                    width: 100.w,
                    clipBehavior: Clip.hardEdge,
                    margin: EdgeInsets.symmetric(
                      horizontal: 4.w,
                    ),
                    child: CachedImage(imageUrl: homeCubit.libraryImage),
                  ),
                  SizedBox(height: 1.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Text(
                        style: AppTextStyles.secondTitle,
                        homeCubit.libraryDescription!),
                  ),
                  SizedBox(height: 2.h),
                ],
              );
            },
          ),
      ],
    );
  }
}

class SectionsLayer extends StatelessWidget {
  const SectionsLayer({
    super.key,
    required this.homeCubit,
  });

  final HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    if (homeCubit.sections.isNotEmpty || homeCubit.state is HomeLoadingState) {
      return Column(
        children: [
          ViewAll(
              text: "الأقسام",
              onPressed: () {
                pushTo(context: context, toPage: SectionsScreen());
              }),
          SizedBox(height: 2.h),
          Builder(builder: (context) {
            if (homeCubit.state is HomeLoadingState) {
              return const CarousalCarousalSectionsShimmer();
            }

            return SectionsCarousal(
              homeCubit: homeCubit,
            );
          }),
          SizedBox(height: 3.h),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}

class OffersLayer extends StatelessWidget {
  const OffersLayer({
    super.key,
    required this.homeCubit,
  });
  final HomeCubit homeCubit;
  @override
  Widget build(BuildContext context) {
    if (homeCubit.offers.isNotEmpty || homeCubit.state is HomeLoadingState) {
      return Column(
        children: [
          ViewAll(
            onPressed: () {
              pushTo(context: context, toPage: const OffersScreen());
            },
            text: "العروض",
          ),
          SizedBox(height: 2.h),
          Builder(builder: (context) {
            if (homeCubit.state is HomeLoadingState) {
              return const CarousalOffersShimmer();
            }

            return OffersCarousal(
              offersList: homeCubit.offers,
            );
          }),
          SizedBox(height: 3.h),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
