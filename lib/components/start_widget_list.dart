import 'package:flutter/material.dart';
import 'package:school_agenda/_common/my_colors.dart';
import 'package:school_agenda/components/add_edit_discipline.dart';
import 'package:school_agenda/models/discipline.model.dart';
import 'package:school_agenda/services/discipline.service.dart';
import 'package:school_agenda/views/discipline.view.dart';

class StartList extends StatelessWidget {
  final DisciplineModel disciplineModel;
  final DisciplineService service;
  const StartList(
      {super.key, required this.disciplineModel, required this.service});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Discipline(disciplineModel: disciplineModel),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 3,
                color: Colors.black.withAlpha(100),
                spreadRadius: 1,
                offset: const Offset(1, 1))
          ],
          borderRadius: BorderRadius.circular(16),
        ),
        height: 90,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
        child: Stack(children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              decoration: const BoxDecoration(
                color: MyColors.darkGrey,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16)),
              ),
              height: 30,
              width: 150,
              child: Center(
                child: Text(
                  disciplineModel.year,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 180,
                      child: Text(
                        disciplineModel.name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: MyColors.darkGrey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            showAddEditDiscipline(context,
                                disciplineModel: disciplineModel);
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            SnackBar snackBar = SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                  "Deseja realmente remover a disciplina ${disciplineModel.name}"),
                              action: SnackBarAction(
                                label: "REMOVER",
                                textColor: Colors.white,
                                onPressed: () {
                                  service.removeDiscipline(
                                      disciplineId: disciplineModel.id);
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
