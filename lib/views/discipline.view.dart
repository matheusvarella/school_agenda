import 'package:flutter/material.dart';
import 'package:school_agenda/models/daily_report.model.dart';
import 'package:school_agenda/models/discipline.model.dart';

class Discipline extends StatelessWidget {
  Discipline({super.key});

  final DisciplineModel disciplineModel =
      DisciplineModel(id: "1", name: "Agro", year: "2023");

  final List<DailyReportModel> dailyReportList = [
    DailyReportModel(
        id: "1",
        numberClass: "2",
        date: "13/02/2024",
        attendance: "true",
        disciplineId: "1"),
    DailyReportModel(
        id: "1",
        numberClass: "2",
        date: "13/02/2024",
        attendance: "true",
        disciplineId: "1"),
    DailyReportModel(
        id: "1",
        numberClass: "2",
        date: "13/02/2024",
        attendance: "true",
        disciplineId: "1"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Column(
            children: [
              const Text(
                "Disciplina",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                disciplineModel.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: Colors.cyan,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(32),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("TESTE");
          },
          child: const Icon(Icons.add),
        ),
        body: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: ListView(
            children: List.generate(dailyReportList.length, (index) {
              DailyReportModel dailyReportModel = dailyReportList[index];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text("Data: ${dailyReportModel.date}"),
                leading: const Icon(Icons.add),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    print("Deletar?");
                  },
                ),
              );
            }),
          ),
        ));
  }
}
