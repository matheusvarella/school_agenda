import 'package:flutter/material.dart';
import 'package:school_agenda/_common/my_colors.dart';
import 'package:school_agenda/components/decoration_authentication_field.dart';
import 'package:school_agenda/models/discipline.model.dart';
import 'package:school_agenda/services/discipline.service.dart';
import 'package:uuid/uuid.dart';

showAddEditDiscipline(BuildContext context,
    {DisciplineModel? disciplineModel}) {
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
      return DisciplineModal(disciplineModel: disciplineModel);
    },
  );
}

class DisciplineModal extends StatefulWidget {
  final DisciplineModel? disciplineModel;
  const DisciplineModal({super.key, this.disciplineModel});

  @override
  State<DisciplineModal> createState() => _DisciplineModalState();
}

class _DisciplineModalState extends State<DisciplineModal> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  bool isLoading = false;

  final DisciplineService _disciplineService = DisciplineService();

  @override
  void initState() {
    if (widget.disciplineModel != null) {
      _nameController.text = widget.disciplineModel!.name;
      _yearController.text = widget.disciplineModel!.year;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      height: MediaQuery.of(context).size.height * 0.45,
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
                        (widget.disciplineModel != null)
                            ? "Editar ${widget.disciplineModel!.name}"
                            : "Adicionar disciplina",
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
                      controller: _nameController,
                      decoration: getAuthenticationInputDecoration(
                        "Disciplina",
                        icon: const Icon(
                          Icons.book,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _yearController,
                      decoration: getAuthenticationInputDecoration(
                        "Ano",
                        icon: const Icon(
                          Icons.numbers,
                          color: Colors.white,
                        ),
                      ),
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
                  : Text((widget.disciplineModel != null)
                      ? "Editar disciplina"
                      : "Adicionar disciplina"),
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

    String name = _nameController.text;
    String year = _yearController.text;

    DisciplineModel disciplineModel = DisciplineModel(
      id: const Uuid().v1(),
      name: name,
      year: year,
    );

    if (widget.disciplineModel != null) {
      disciplineModel.id = widget.disciplineModel!.id;
    }

    _disciplineService.addDiscipline(disciplineModel).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }
}
