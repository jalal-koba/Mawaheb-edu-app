import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart'; 
import 'package:talents/Modules/Payments_Orders/Cubit/payments_cubit.dart';
import 'package:talents/Modules/Payments_Orders/Cubit/payments_state.dart';
import 'package:talents/Modules/Payments_Orders/Model/payment_order.dart';
import 'package:talents/Modules/Payments_Orders/View/Widgets/payment_order_card.dart';
import 'package:talents/Modules/Widgets/app_loading.dart';
import 'package:talents/Modules/Widgets/app_scaffold.dart'; 
import 'package:talents/Modules/Widgets/no_data.dart';
import 'package:talents/Modules/Widgets/try_agin.dart';

import '../Widgets/buttons_tab_bar_view.dart'; 

class PaymentOrdersScreen extends StatefulWidget {
  const PaymentOrdersScreen({super.key});

  @override
  State<PaymentOrdersScreen> createState() => _PaymentOrdersScreenState();
}

class _PaymentOrdersScreenState extends State<PaymentOrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  PaymentsCubit paymentsCubit = PaymentsCubit();
  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    paymentsCubit.getPaymentsOrders();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        title: "طلبات الشراء",
        body: BlocProvider(
          create: (context) => paymentsCubit,
          child: BlocBuilder<PaymentsCubit, PaymentsState>(
              builder: (context, state) {
            final PaymentsCubit paymentsCubit = PaymentsCubit.get(context);

            if (state is PaymentsOrdersErrorState) {
              return TryAgain(
                message: state.message,
                onTap: () {
                  paymentsCubit.getPaymentsOrders();
                },
              );
            }

            if (state is PaymentsOrdersLoadingState) {
              return const AppLoading();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ButtonsTabBarView(
                  tabController: tabController,
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      Orders(list: paymentsCubit.allOrders),
                      Orders(list: paymentsCubit.acceptedOrders),
                      Orders(list: paymentsCubit.pendingOrders),
                      Orders(list: paymentsCubit.rejectedOrders),
                    ],
                  ),
                )
              ],
            );
          }),
        ));
  }
}

class Orders extends StatelessWidget {
  const Orders({
    super.key,
    required this.list,
  });
  final List<PaymentOrder> list;
  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return const Nodata();
    }
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
      itemCount: list.length,
      itemBuilder: (context, index) => PaymentOrderCard(order: list[index]),
    );
  }
}
