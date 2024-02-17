class DisciplineModel {
  String id;
  String name;
  String year;

  DisciplineModel({required this.id, required this.name, required this.year});

  DisciplineModel.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        year = map["year"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "year": year,
    };
  }
}
