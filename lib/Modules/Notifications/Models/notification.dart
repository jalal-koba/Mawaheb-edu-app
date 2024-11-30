import 'package:talents/Modules/Utils/bool_converter.dart';

class Notifications {
  final int currentPage;
  final List<AppNotification> data;

  Notifications({
    required this.currentPage,
    required this.data,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        currentPage: json["current_page"],
        data: List<AppNotification>.from(
            json["data"].map((x) => AppNotification.fromJson(x))),
      );
}

class AppNotification {
  final int id;
  final String title;
  final String description;
  final bool hasRead;
  final String type;
  final String date;
  final int state;
  final dynamic additionalData;

  AppNotification({
    required this.id,
    required this.title,
    required this.description,
    required this.hasRead,
    required this.type,
    required this.date,
    required this.state,
    required this.additionalData,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      AppNotification(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        hasRead:  boolConverter(json["has_read"]) ,
        type: json["type"],
        state: json["state"],
        date: json["created_at"],
        additionalData: json["additional_data"],
      );
}
