import 'package:talents/Modules/Notifications/Models/notification.dart';

class NotificationsResponse {
  final Notifications data;
  final int code;
  final int notificationsCount;

  NotificationsResponse({
    required this.data,
    required this.code,
    required this.notificationsCount,
  });

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) =>
      NotificationsResponse(
        data: Notifications.fromJson(json["data"]),
        code: json["code"],
        notificationsCount: json["notifications_count"],
      );
}
