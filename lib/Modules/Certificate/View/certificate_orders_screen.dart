import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Modules/Certificate/Cubit/cubit/certificate_cubit.dart';
import 'package:talents/Modules/Certificate/Model/certificate_order.dart';
import 'package:talents/Modules/Certificate/View/widgets/certificate_order_card.dart';

import 'package:talents/Modules/Payments_Orders/View/Widgets/buttons_tab_bar_view.dart';
import 'package:talents/Modules/Widgets/app_loading.dart';
import 'package:talents/Modules/Widgets/app_scaffold.dart';
import 'package:talents/Modules/Widgets/no_data.dart';
import 'package:talents/Modules/Widgets/try_agin.dart';

class CertificateOrdersScreen extends StatefulWidget {
  const CertificateOrdersScreen({super.key});

  @override
  State<CertificateOrdersScreen> createState() => _CertificateOrdersState();
}

class _CertificateOrdersState extends State<CertificateOrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late CertificateCubit certificateCubit;
  @override
  void initState() {
    certificateCubit = CertificateCubit()..getCertificates();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(
      () {
        print(tabController.index);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        title: "الشهادات",
        body: BlocProvider(
          create: (context) => certificateCubit,
          child: BlocBuilder<CertificateCubit, CertificateState>(
            builder: (context, state) {
              final CertificateCubit certificateCubit =
                  CertificateCubit.get(context);

              if (state is CertificateLoadingState) {
                return const AppLoading();
              }
              if (state is CertificateErrorState) {
                return TryAgain(
                    message: state.message,
                    onTap: () {
                      certificateCubit.getCertificates();
                    });
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ButtonsTabBarView(
                    tabController: tabController,
                    tabBarTitles: const [
                      "الكل",
                      "شهاداتي",
                      "قيد الانتظار",
                      "مرفوضة"
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        OrderList(
                            certificateOrders: certificateCubit.allOrders),
                        OrderList(
                            certificateOrders: certificateCubit.acceptedOrders),
                        OrderList(
                            certificateOrders: certificateCubit.pendingOrders),
                        OrderList(
                            certificateOrders: certificateCubit.rejectedOrders),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ));
  }
}

class OrderList extends StatelessWidget {
  const OrderList({
    super.key,
    required this.certificateOrders,
  });

  final List<CertificateOrder> certificateOrders;

  @override
  Widget build(BuildContext context) {
    if (certificateOrders.isEmpty) {
      return const Nodata();
    }
    return ListView.builder(
        itemCount: certificateOrders.length,
        padding: EdgeInsets.symmetric(vertical: 2.h),
        itemBuilder: (context, index) => CertificateOrderCard(
              certificateOrder: certificateOrders[index],
            ));
  }
}
