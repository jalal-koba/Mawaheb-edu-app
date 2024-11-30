class Option {
  final int id;
  final String name;
  final bool? isTrue;
  final bool? isChosen;

  Option({
    required this.id,
    required this.name,
    required this.isTrue,
    required this.isChosen,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    id: json["id"],
    name: json["name"],
    isTrue: json["is_true"] == 1 || json["is_true"] == "1",
    isChosen: json["is_chosen"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "is_true": isTrue,
    "is_chosen": isChosen,
  };
}