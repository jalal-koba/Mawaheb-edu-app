  

import 'package:talents/Modules/Payments_Orders/Model/section.dart';

class SectionsResponse {
  final Data data;
  final int code;

  SectionsResponse({
    required this.data,
    required this.code,
  });

  factory SectionsResponse.fromJson(Map<String, dynamic> json) =>
      SectionsResponse(
        data: Data.fromJson(json["data"]),
        code: json["code"],
      );

  
}

class Data {
  final int currentPage;
  final List<Section> data; 

  Data({
    required this.currentPage,
    required this.data, 
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<Section>.from(json["data"].map((x) => Section.fromJson(x))), 
      );
 
}

 
