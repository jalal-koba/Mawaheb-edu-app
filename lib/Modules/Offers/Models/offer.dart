class Offer {
  final int id;
  final String? name;
  final String? description;
  final int? discount;
  final String? image;

  Offer({
    required this.id,
    required this.name,
    required this.description,
    required this.discount,
    required this.image,
  });

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        discount: json["discount"] != 0 ? json["discount"] : null,
        image: json["image"],
      );
}
