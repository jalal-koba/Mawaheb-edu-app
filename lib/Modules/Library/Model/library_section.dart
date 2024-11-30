class LibrarySection {
  final int id;
  final dynamic parentId;
  final String type;
  final String name;
  final String image;
  final String description;
  final dynamic subSections;
  final dynamic lessons;

  LibrarySection({
    required this.id,
    required this.parentId,
    required this.type,
    required this.name,
    required this.image,
    required this.description,
    required this.subSections,
    required this.lessons,
  });

  factory LibrarySection.fromJson(Map<String, dynamic> json) => LibrarySection(
        id: json["id"],
        parentId: json["parent_id"],
        type: json["type"],
        name: json["name"],
        image: json["image"],
        description: json["description"],
        subSections: json["sub_sections"],
        lessons: json["lessons"],
      );
}
