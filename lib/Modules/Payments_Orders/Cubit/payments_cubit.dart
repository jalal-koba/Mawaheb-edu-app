import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talents/Apis/exception_handler.dart';
import 'package:talents/Apis/network.dart';
import 'package:talents/Apis/urls.dart';
import 'package:talents/Modules/Payments_Orders/Cubit/payments_state.dart';
import 'package:talents/Modules/Payments_Orders/Model/payment_order.dart';
import 'package:talents/Modules/Payments_Orders/Model/payment_ordre_response.dart';

class PaymentsCubit extends Cubit<PaymentsState> {
  PaymentsCubit() : super(PaymentsInitialState());

  static PaymentsCubit get(context) => BlocProvider.of(context);
  List<PaymentOrder> allOrders = [];
  List<PaymentOrder> pendingOrders = [];
  List<PaymentOrder> acceptedOrders = [];
  List<PaymentOrder> rejectedOrders = [];
  late PaymentOrdersResponse _paymentOrdersState;
  int currentTab = 0;
  void changeTab(int index) {
    currentTab = index;
    emit(ChangeTabState());
  }

  Future<void> getPaymentsOrders() async {
    emit(PaymentsOrdersLoadingState());

    try {
      Response response = await Network.getData(
        url: "${Urls.payCourse}?get=1",  
      );
      _paymentOrdersState = PaymentOrdersResponse.fromJson(response.data);

      allOrders = _paymentOrdersState.data.data;

      pendingOrders = allOrders
          .where(
            (element) => element.status == "pending",
          )
          .toList();
      acceptedOrders = allOrders
          .where(
            (element) => element.status == "accepted",
          )
          .toList();
      rejectedOrders = allOrders
          .where(
            (element) => element.status == "rejected",
          )
          .toList();

      emit(PaymentsOrdersSuccess());
    } on DioException catch (error) {
      emit(PaymentsOrdersErrorState(message: exceptionsHandle(error: error)));
    }
      //  catch (error) {
      //   emit(PaymentsOrdersErrorState(message: "حدث خطأ ما"));
      // }
  }
}
