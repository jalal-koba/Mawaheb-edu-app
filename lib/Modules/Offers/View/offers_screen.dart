
import 'package:animate_do/animate_do.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:sizer/sizer.dart';



import 'package:talents/Modules/Offers/Cubit/offers_cubit.dart';

import 'package:talents/Modules/Offers/Cubit/offers_state.dart';

import 'package:talents/Modules/Offers/View/Widgets/offer_card.dart';
import 'package:talents/Modules/Widgets/app_footer.dart';
 
import 'package:talents/Modules/Widgets/app_shimmer.dart';


import 'package:talents/Modules/Widgets/refresher_header.dart';

import 'package:talents/Modules/Widgets/try_agin.dart';


import '../../Widgets/app_scaffold.dart';


class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  OffersCubit offersCubit = OffersCubit();

  @override
  void initState() {
    offersCubit.page = 1; // to
    offersCubit.refreshController = RefreshController();
    offersCubit.getOffers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        title: "العروض",
        body: BlocProvider(
            create: (context) => offersCubit,
            child: BlocBuilder<OffersCubit, OffersState>(
                builder: (BuildContext context, state) {
              final OffersCubit offersCubit = OffersCubit.get(context);

              if (state is OffersErrorState) {
                return TryAgain( message: state.message,
                  onTap: () {
                    offersCubit.getOffers();
                  },
                );
              }

              if (state is OffersLoadingState) {
                return const OffersShimmer();
              }
              return SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                onRefresh: () {
                  offersCubit.page = 1;
                  offersCubit.getOffers();
                  offersCubit.refreshController = RefreshController();
                },
        footer: const AppFooter(
                title:    'لا يوجد المزيد من العروض',
              ),
                onLoading: () {
                  offersCubit.getOffers();
                },
                header: const AppRefresherHeader(),
                controller: offersCubit.refreshController,
                child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(height: 2.h),
                    itemCount: offersCubit.offers.length,
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                    itemBuilder: (context, index) => FadeInDown(
                          duration:
                              Duration(milliseconds: 300 + 150 * (index % 3)),
                          child: OfferCard(
                            offer: offersCubit.offers[index],
                          ),
                        )),
              );
            })));
  }
}

class OffersShimmer extends StatelessWidget {
  const OffersShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: ListView.builder(
        itemCount: 5,
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(20)),
          width: 90.w,
          margin: EdgeInsets.all(3.w),
          height: 22.h,
        ),
      ),
    );
  }
}
