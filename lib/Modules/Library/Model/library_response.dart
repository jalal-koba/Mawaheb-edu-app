import 'package:talents/Modules/Library/Model/book.dart';

class BooksResponse {
  final Data data; 

  BooksResponse({
    required this.data, 
  });

  factory BooksResponse.fromJson(Map<String, dynamic> json) => BooksResponse(
        data: Data.fromJson(json["data"]), 
      );
}

class Data {
  final int currentPage;
  final List<Book> data;

  Data({
    required this.currentPage,
    required this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<Book>.from(json["data"].map((x) => Book.fromJson(x))),
      );
}
