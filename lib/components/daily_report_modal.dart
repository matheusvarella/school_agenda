import 'package:flutter/material.dart';
import 'package:school_agenda/_common/my_colors.dart';
import 'package:school_agenda/components/decoration_authentication_field.dart';
import 'package:school_agenda/models/daily_report.model.dart';
import 'package:school_agenda/services/daily_report.service.dart';
import 'package:uuid/uuid.dart';

showAddEditDailyReportModal(BuildContext context,
    {required String disciplineId, DailyReportModel? dailyReportModel}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: MyColors.grey,
    isDismissible: false,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(32),
      ),
    ),
    builder: (context) {
      return DailyReportModal(
          disciplineId: disciplineId, dailyReportModel: dailyReportModel);
    },
  );
}

class DailyReportModal extends StatefulWidget {
  final DailyReportModel? dailyReportModel;
  final String disciplineId;
  const DailyReportModal(
      {super.key, required this.disciplineId, this.dailyReportModel});

  @override
  State<DailyReportModal> createState() => _DailyReportModalState();
}

class _DailyReportModalState extends State<DailyReportModal> {
  final TextEditingController _numberClassController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  bool isLoading = false;
  bool isChecked = false;

  final DailyReportService _dailyReportService = DailyReportService();

  @override
  void initState() {
    if (widget.dailyReportModel != null) {
      _numberClassController.text = widget.dailyReportModel!.numberClass;
      _dateController.text = widget.dailyReportModel!.date;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      height: MediaQuery.of(context).size.height * 0.5,
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        (widget.dailyReportModel != null)
                            ? "Editar ${widget.dailyReportModel!.date}"
                            : "Adicionar relatório",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close, color: Colors.white))
                  ],
                ),
                const Divider(),
                Column(
                  children: [
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _numberClassController,
                      decoration: getAuthenticationInputDecoration(
                        "Número de aulas",
                        icon: const Icon(
                          Icons.numbers,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _dateController,
                      decoration: getAuthenticationInputDecoration(
                        "Data no formato (dd/MM/yyyy)",
                        icon: const Icon(
                          Icons.numbers,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text("Esteve presente na aula?"),
                        Checkbox(
                            value: isChecked,
                            onChanged: (bool? newValue) {
                              setState(() {
                                isChecked = newValue!;
                              });
                            })
                      ],
                    )
                  ],
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                sendDiscipline();
              },
              child: isLoading
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        color: MyColors.grey,
                      ),
                    )
                  : Text((widget.dailyReportModel != null)
                      ? "Editar relatório"
                      : "Adicionar relatório"),
            ),
          ],
        ),
      ),
    );
  }

  sendDiscipline() {
    setState(() {
      isLoading = true;
    });

    // String name = _nameController.text;
    // String year = _yearController.text;
    String numberClass = _numberClassController.text;
    String date = _dateController.text;
    String attendance = "1";

    DailyReportModel dailyReportModel = DailyReportModel(
      id: const Uuid().v1(),
      numberClass: numberClass,
      date: date,
      attendance: attendance,
      disciplineId: widget.disciplineId,
    );

    if (widget.dailyReportModel != null) {
      dailyReportModel.id = widget.dailyReportModel!.id;
    }

    _dailyReportService
        .addDailyReport(
            disciplineId: widget.disciplineId,
            dailyReportModel: dailyReportModel)
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }
}
