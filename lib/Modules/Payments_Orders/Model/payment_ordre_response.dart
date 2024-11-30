import 'package:talents/Modules/Payments_Orders/Model/payment_order.dart';

class PaymentOrdersResponse {
  final Data data;
  final int code;

  PaymentOrdersResponse({
    required this.data,
    required this.code,
  });

  factory PaymentOrdersResponse.fromJson(Map<String, dynamic> json) =>
      PaymentOrdersResponse(
        data: Data.fromJson(json["data"]),
        code: json["code"],
      );
}

class Data {
  final int currentPage;
  final List<PaymentOrder> data; 

  Data({
    required this.currentPage,
    required this.data, 
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<PaymentOrder>.from(
            json["data"].map((x) => PaymentOrder.fromJson(x))), 
      );
}
