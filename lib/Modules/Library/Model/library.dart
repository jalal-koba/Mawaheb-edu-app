class Library {
  final String image;
  final String description;

  Library({
    required this.image,
    required this.description,
  });

  factory Library.fromJson(Map<String, dynamic> json) => Library(
        image: json["image"],
        description: json["description"],
      );
}
