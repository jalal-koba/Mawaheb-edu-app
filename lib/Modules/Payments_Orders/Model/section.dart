class Section {
  final int id;
  final String name;
  final String? image;
  final String description;
  final int? price;
  final String? introVideo;

  Section({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.introVideo,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        description: json["description"] ?? '',
        price: json["price"] ?? 0,
        introVideo: json["intro_video"],
      );
}
