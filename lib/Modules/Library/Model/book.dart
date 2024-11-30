class Book {
    final int id;
    final String name;
    final String image;
    final String file;
    final String description;
    final dynamic deletedAt;

    Book({
        required this.id,
        required this.name,
        required this.image,
        required this.file,
        required this.description,
        required this.deletedAt,
    });

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        file: json["file"],
        description: json["description"],
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "file": file,
        "description": description,
        "deleted_at": deletedAt,
    };
}
