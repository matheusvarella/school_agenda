import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:school_agenda/models/daily_report.model.dart';

class DailyReportService {
  String userId;
  DailyReportService() : userId = FirebaseAuth.instance.currentUser!.uid;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String key = "dailyReport";

  Future<void> addDailyReport({
    required String disciplineId,
    required DailyReportModel dailyReportModel,
  }) async {
    return await _firestore
        .collection(userId)
        .doc(disciplineId)
        .collection(key)
        .doc(dailyReportModel.id)
        .set(dailyReportModel.toMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> connectStream(
      {required String disciplineId}) {
    return _firestore
        .collection(userId)
        .doc(disciplineId)
        .collection(key)
        .orderBy("date", descending: true)
        .snapshots();
  }

  Future<void> removeDailyReport(
      {required String disciplineId, required String dailyReportId}) async {
    _firestore
        .collection(userId)
        .doc(disciplineId)
        .collection(key)
        .doc(dailyReportId)
        .delete();
  }
}
