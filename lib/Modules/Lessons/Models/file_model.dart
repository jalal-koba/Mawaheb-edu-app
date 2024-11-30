class FileModel {
  final int id;
  final String path;
  final String name;
  final String url;
  final String type;
  final String extension;
  final int size;
  final dynamic deletedAt;

  FileModel({
    required this.id,
    required this.path,
    required this.name,
    required this.url,
    required this.type,
    required this.extension,
    required this.size,
    required this.deletedAt,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) => FileModel(
        id: json["id"],
        path: json["path"],
        name: json["name"],
        url: json["url"],
        type: json["type"],
        extension: json["extension"],
        size: json["size"],
        deletedAt: json["deleted_at"],
      );
}
