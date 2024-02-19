import 'package:flutter/material.dart';
import 'package:school_agenda/_common/my_colors.dart';
import 'package:school_agenda/components/daily_report_modal.dart';
import 'package:school_agenda/models/daily_report.model.dart';
import 'package:school_agenda/models/discipline.model.dart';
import 'package:school_agenda/services/daily_report.service.dart';

class Discipline extends StatelessWidget {
  final DisciplineModel disciplineModel;
  Discipline({super.key, required this.disciplineModel});

  final DailyReportService _dailyReportService = DailyReportService();

  final List<DailyReportModel> dailyReportList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.grey,
      appBar: AppBar(
        title: Column(
          children: [
            const Text(
              "Disciplina",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              disciplineModel.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: MyColors.greyUpGradient,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(32),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddEditDailyReportModal(context,
              disciplineId: disciplineModel.id);
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: StreamBuilder(
          stream: _dailyReportService.connectStream(
              disciplineId: disciplineModel.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasData &&
                  snapshot.data != null &&
                  snapshot.data!.docs.isNotEmpty) {
                final List<DailyReportModel> dailyReportList = [];

                for (var doc in snapshot.data!.docs) {
                  dailyReportList.add(DailyReportModel.fromMap(doc.data()));
                }

                return ListView(
                  children: List.generate(dailyReportList.length, (index) {
                    DailyReportModel dailyReportModel = dailyReportList[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text("Data: ${dailyReportModel.date}"),
                      subtitle: Text((dailyReportModel.attendance == "1")
                          ? "Presenças ${dailyReportModel.numberClass}"
                          : "Faltas ${dailyReportModel.numberClass}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          SnackBar snackBar = SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                                "Deseja realmente remover a disciplina ${dailyReportModel.date}"),
                            action: SnackBarAction(
                              label: "REMOVER",
                              textColor: Colors.white,
                              onPressed: () {
                                _dailyReportService.removeDailyReport(
                                    disciplineId: disciplineModel.id,
                                    dailyReportId: dailyReportModel.id);
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                      ),
                    );
                  }),
                );
              } else {
                return const Text("Nenhuma anotação.");
              }
            }
          },
        ),
      ),
    );
  }
}
