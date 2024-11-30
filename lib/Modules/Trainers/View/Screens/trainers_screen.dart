import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Trainers/Cubit/trainers_cubit.dart';
import 'package:talents/Modules/Trainers/Cubit/trainers_state.dart';
import 'package:talents/Modules/Trainers/View/Screens/trainer_info_screen.dart';
import 'package:talents/Modules/Home/View/Widgets/trainer_card.dart';
import 'package:talents/Modules/Widgets/app_footer.dart';
import 'package:talents/Modules/Widgets/refresher_header.dart';
import 'package:talents/Modules/Widgets/try_agin.dart';
import '../../../Widgets/app_scaffold.dart';
import '../Widgets/trainers_shimmer.dart';

class TrainersScreen extends StatelessWidget {
  TrainersScreen({super.key});

  final TrainersCubit trainersCubit = TrainersCubit()..getTrainers();
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        title: "المدربين",
        body: BlocProvider(
          create: (context) => trainersCubit,
          child: BlocBuilder<TrainersCubit, TrainerState>(
              builder: (context, state) {
            if (state is TrainerErrorState) {
              return TryAgain(
                  message: state.message,
                  onTap: () => trainersCubit.getTrainers());
            }

            if (state is TrainerLoadingState) {
              return const TrainersShimmer();
            }
            return SmartRefresher(
              header: const AppRefresherHeader(),
              controller: trainersCubit.refreshController,
              enablePullUp: true,
              enablePullDown: true,
              onLoading: () {
                trainersCubit.getTrainers();
              },
              onRefresh: () async {
                trainersCubit.page = 1;
                await trainersCubit.getTrainers();
                trainersCubit.refreshController.refreshCompleted();
                trainersCubit.refreshController.loadComplete();
              },
              footer: const AppFooter(
                title: 'لا يوجد المزيد من المدربين',
              ),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.7,
                    mainAxisSpacing: 1.h,
                    crossAxisSpacing: 1.w,
                    crossAxisCount: 2),
                itemCount: trainersCubit.trainers.length,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                itemBuilder: (context, index) => InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    pushTo(
                        context: context,
                        toPage: TrainerInfoScreen(
                          name: trainersCubit.trainers[index].fullName,
                          id: trainersCubit.trainers[index].id,
                        ));
                  },
                  child: TrainerCard(
                    isHome: false,
                    trainer: trainersCubit.trainers[index],
                  ),
                ),
              ),
            );
          }),
        ));
  }
}
