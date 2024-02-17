class DailyReportModel {
  String id;
  String numberClass;
  String date;
  String attendance;
  String disciplineId;

  DailyReportModel(
      {required this.id,
      required this.numberClass,
      required this.date,
      required this.attendance,
      required this.disciplineId});

  DailyReportModel.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        numberClass = map["numberClass"],
        date = map["date"],
        attendance = map["attendance"],
        disciplineId = map["disciplineId"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "numberClass": numberClass,
      "date": date,
      "attendance": attendance,
      "disciplineId": disciplineId,
    };
  }
}
