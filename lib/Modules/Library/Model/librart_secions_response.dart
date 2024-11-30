import 'package:talents/Modules/Library/Model/library_section.dart';

class LibrarySectionsResponse {
  final Data data;
  final int code;

  LibrarySectionsResponse({
    required this.data,
    required this.code,
  });

  factory LibrarySectionsResponse.fromJson(Map<String, dynamic> json) =>
      LibrarySectionsResponse(
        data: Data.fromJson(json["data"]),
        code: json["code"],
      );
}

class Data {
  final int currentPage;
  final List<LibrarySection> sections; 
  Data({
    required this.currentPage,
    required this.sections, 
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        sections:
            List<LibrarySection>.from(json["data"].map((x) => LibrarySection.fromJson(x))), 
      );
}
