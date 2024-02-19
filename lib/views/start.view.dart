import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:school_agenda/_common/my_colors.dart';
import 'package:school_agenda/components/add_edit_discipline.dart';
import 'package:school_agenda/components/start_widget_list.dart';
import 'package:school_agenda/models/discipline.model.dart';
import 'package:school_agenda/services/authentication.service.dart';
import 'package:school_agenda/services/discipline.service.dart';

class StartView extends StatefulWidget {
  final User user;
  const StartView({super.key, required this.user});

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  final DisciplineService service = DisciplineService();

  bool isDescending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.greyLowGradient,
      appBar: AppBar(
        title: const Text("Minhas matérias"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isDescending = !isDescending;
                });
              },
              icon: const Icon(Icons.sort_by_alpha))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: const CircleAvatar(
                  backgroundImage: AssetImage("assets/logo.png")),
              accountName: Text((widget.user.displayName != null)
                  ? widget.user.displayName!
                  : ""),
              accountEmail: Text(widget.user.email!),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Deslogar"),
              onTap: () {
                AuthenticationService().logout();
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showAddEditDiscipline(context);
        },
      ),
      body: StreamBuilder(
        stream: service.connectStreamDiscipline(isDescending),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData &&
                snapshot.data != null &&
                snapshot.data!.docs.isNotEmpty) {
              List<DisciplineModel> disciplineList = [];

              for (var doc in snapshot.data!.docs) {
                disciplineList.add(DisciplineModel.fromMap(doc.data()));
              }

              return ListView(
                  children: List.generate(disciplineList.length, (index) {
                DisciplineModel disciplineModel = disciplineList[index];
                return StartList(
                    disciplineModel: disciplineModel, service: service);
              }));
            } else {
              return const Center(
                child: Text("Ainda não possui disciplina cadastrada"),
              );
            }
          }
        },
      ),
    );
  }
}
