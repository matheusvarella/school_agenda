import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:school_agenda/models/daily_report.model.dart';
import 'package:school_agenda/models/discipline.model.dart';

class DisciplineService {
  String userId;
  DisciplineService() : userId = FirebaseAuth.instance.currentUser!.uid;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addDiscipline(DisciplineModel disciplineModel) async {
    return await _firestore
        .collection(userId)
        .doc(disciplineModel.id)
        .set(disciplineModel.toMap());
  }

  Future<void> addDailyReport(
      String disciplineId, DailyReportModel dailyReportModel) async {
    return await _firestore
        .collection(userId)
        .doc(disciplineId)
        .collection("dailyReport")
        .doc(dailyReportModel.id)
        .set(dailyReportModel.toMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> connectStreamDiscipline(
      bool isDescending) {
    return _firestore
        .collection(userId)
        .orderBy("name", descending: isDescending)
        .snapshots();
  }

  Future<void> removeDiscipline({required String disciplineId}) {
    return _firestore.collection(userId).doc(disciplineId).delete();
  }
}
