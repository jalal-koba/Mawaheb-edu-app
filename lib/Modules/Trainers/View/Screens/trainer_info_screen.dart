import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Courses/View/Widgets/course_card.dart';
import 'package:talents/Modules/Trainers/Cubit/trainers_cubit.dart';
import 'package:talents/Modules/Trainers/Cubit/trainers_state.dart';
import 'package:talents/Modules/Widgets/app_loading.dart';
import 'package:talents/Modules/Widgets/cached_image.dart';
import 'package:talents/Modules/Widgets/try_agin.dart';
import '../../../Widgets/app_scaffold.dart';

class TrainerInfoScreen extends StatelessWidget {
  TrainerInfoScreen({
    super.key,
    required this.id,
    required this.name,
  });
  final int id;
  final String name;
  final TrainersCubit trainersCubit = TrainersCubit();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        title: name,
        body: BlocProvider(
          create: (context) => trainersCubit..getTrainerInfo(id),
          child: BlocBuilder<TrainersCubit, TrainerState>(
            builder: (context, state) {
              if (state is TrainerErrorState) {
                return TryAgain(
                    message: state.message,
                    onTap: () {
                      trainersCubit.getTrainerInfo(id);
                    });
              }

              if (state is TrainerLoadingState) {
                return const AppLoading();
              }
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 2.w,
                ),
                child: CustomScrollView(
                  slivers: [
                    _TrainerInfo(trainersCubit: trainersCubit),
                    _CoursesList(trainersCubit: trainersCubit, id: id),
                  ],
                ),
              );
            },
          ),
        ));
  }
}

class _CoursesList extends StatelessWidget {
  const _CoursesList({
    required this.trainersCubit,
    required this.id,
  });

  final TrainersCubit trainersCubit;
  final int id;
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      sliver: SliverList.builder(
        itemBuilder: (context, index) => CourseCard(
          callback: () {
            trainersCubit.getTrainerInfo(id);
          },
          index: index,
          tag: "doctor$index",
          course: trainersCubit.courses[index],
        ),
        itemCount: trainersCubit.courses.length,
      ),
    );
  }
}

class _TrainerInfo extends StatelessWidget {
  const _TrainerInfo({
    required this.trainersCubit,
  });

  final TrainersCubit trainersCubit;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 1.h,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
                width: 40.w,
                height: 20.h,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: blueBoxShadow,
                    shape: BoxShape.circle),
                child: trainersCubit.imageUrl != null
                    ? CachedImage(
                        isPerson: true,
                        imageUrl: trainersCubit.imageUrl,
                      )
                    : Icon(
                        Icons.person,
                        color: AppColors.secondary,
                        size: 50.sp,
                      )),
          ),
          SizedBox(height: 3.h),
          Text(
            trainersCubit.description,
            style: AppTextStyles.explanatoryText,
          ),
          SizedBox(height: 2.5.h),
          if (trainersCubit.courses.isNotEmpty)
            Text('الكورسات',
                style: AppTextStyles.meduimTitle
                    .copyWith(fontWeight: FontWeight.bold)),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
