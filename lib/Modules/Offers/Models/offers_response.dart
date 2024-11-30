import 'package:talents/Modules/Offers/Models/offer.dart';

class OffersResponse {
  final int currentPage;
  final List<Offer> data; 

  OffersResponse({
    required this.currentPage,
    required this.data, 
  });

  factory OffersResponse.fromJson(Map<String, dynamic> json) => OffersResponse(
        currentPage: json["current_page"],
 

        data: List<Offer>.from(json["data"].map((x) => Offer.fromJson(x))), 
      ); 
}
 