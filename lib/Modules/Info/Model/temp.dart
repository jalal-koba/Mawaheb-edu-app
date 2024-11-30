// import 'package:talents/Modules/Info/Model/contact.dart';

// class InfoResponse {
//   final Cash cash;
//   final Contact contact;
//   final Application application;
//   final Footer footer;

//   InfoResponse({
//     required this.cash,
//     required this.contact,
//     required this.application,
//     required this.footer,
//   });

//   factory InfoResponse.fromJson(Map<String, dynamic> json) => InfoResponse(
//         cash: Cash.fromJson(json["cash"]),
//         contact: Contact.fromJson(json["contact"]),
//         application: Application.fromJson(json["application"]),
//         footer: Footer.fromJson(json["footer"]),
//       );
// }

// class Application {
//   final String description;
//   final String appStore;
//   final String googlePlay;

//   Application({
//     required this.description,
//     required this.appStore,
//     required this.googlePlay,
//   });

//   factory Application.fromJson(Map<String, dynamic> json) => Application(
//         description: json["description"],
//         appStore: json["app_store"],
//         googlePlay: json["google_play"],
//       );
 
// }

// class Cash {
//   final String info;

//   Cash({
//     required this.info,
//   });

//   factory Cash.fromJson(Map<String, dynamic> json) => Cash(
//         info: json["info"],
//       );
// }

// class Footer {
//   final String email;
//   final String phone;

//   Footer({
//     required this.email,
//     required this.phone,
//   });

//   factory Footer.fromJson(Map<String, dynamic> json) => Footer(
//         email: json["email"],
//         phone: json["phone"],
//       );
// }
