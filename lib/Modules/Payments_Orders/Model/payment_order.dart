 
import 'package:talents/Modules/Payments_Orders/Model/section.dart';

class PaymentOrder {
  final int id;
  final String image;
  final Section section;
  final String status;
  final DateTime createdAt;

  PaymentOrder({
    required this.id,
    required this.image,
    required this.section,
    required this.status,
    required this.createdAt,
  });

  factory PaymentOrder.fromJson(Map<String, dynamic> json) => PaymentOrder(
        id: json["id"],
        image: json["image"],
        section: Section.fromJson(json["section"]),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
      );
}
