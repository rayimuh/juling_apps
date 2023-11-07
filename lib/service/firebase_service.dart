import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:juling_apps/model/model.dart';
import 'package:juling_apps/model/model_maintenance.dart';
import 'package:juling_apps/variable.dart';

class FirebaseService {
  FirebaseService({required this.firestore});

  final FirebaseFirestore firestore;

  Future<void> addData(InspectionData data) async {
    await firestore.collection("data").doc(data.number).set({
      'date': data.date,
      'number': data.number,
      'found': data.found,
      'dueDate': data.dueDate,
      'progress': data.progress,
      'status': data.status,
      'no SPK': data.SPK,
      'location': data.location,
      'information': data.information,
      'link before': data.linkBefore,
      'link after': data.linkAfter,
      'timestamp': data.timestamp,
      "year": data.year,
      "pic": data.pic,
      "category": data.category,
      "sub-category": data.subCategory
    });
  }

  Future<void> addDataMaintenance(MaintenanceData data) async {
    await firestore.collection("maintenance").doc(data.id).set(
        {'id': data.id, 'Spesifikasi': data.spesifikasi, 'Gambar': data.url});
  }

  Future<void> updateData(String docId, InspectionData newData) async {
    await firestore.collection("data").doc(docId).update(newData.toMap());
  }

  Future<void> updateDataMaintenance(
      String docId, MaintenanceData newData) async {
    await firestore
        .collection("maintenance")
        .doc(docId)
        .update(newData.toMap());
  }

  Future<void> countGT(Timestamp dateStart, Timestamp dateEnd) async {
    var query = firestore
        .collection("data")
        .where("timestamp", isGreaterThanOrEqualTo: dateStart)
        .where("timestamp", isLessThanOrEqualTo: dateEnd);
    var snapshot = await query.get();
    var count = snapshot.size;
    grandTotal = count;
  }

  Future<void> countMP(Timestamp dateStart, Timestamp dateEnd) async {
    var query = firestore
        .collection("data")
        .where("timestamp", isGreaterThanOrEqualTo: dateStart)
        .where("timestamp", isLessThanOrEqualTo: dateEnd)
        .where("progress", isEqualTo: "Material Preparation");
    var snapshot = await query.get();
    var count = snapshot.size;
    materialPrep = count;
  }

  Future<void> countO(Timestamp dateStart, Timestamp dateEnd) async {
    var query = firestore
        .collection("data")
        .where("timestamp", isGreaterThanOrEqualTo: dateStart)
        .where("timestamp", isLessThanOrEqualTo: dateEnd)
        .where("progress", isEqualTo: "Open");
    var snapshot = await query.get();
    var count = snapshot.size;
    open = count;
  }

  Future<void> countC(Timestamp dateStart, Timestamp dateEnd) async {
    var query = firestore
        .collection("data")
        .where("timestamp", isGreaterThanOrEqualTo: dateStart)
        .where("timestamp", isLessThanOrEqualTo: dateEnd)
        .where("progress", isEqualTo: "Completed");
    var snapshot = await query.get();
    var count = snapshot.size;
    completed = count;
  }

  Future<void> countPC(Timestamp dateStart, Timestamp dateEnd) async {
    var query = firestore
        .collection("data")
        .where("timestamp", isGreaterThanOrEqualTo: dateStart)
        .where("timestamp", isLessThanOrEqualTo: dateEnd)
        .where("progress", isEqualTo: "Progress Construction");
    var snapshot = await query.get();
    var count = snapshot.size;
    progressCons = count;
  }

  Future<void> countNU(Timestamp dateStart, Timestamp dateEnd) async {
    var query = firestore
        .collection("data")
        .where("timestamp", isGreaterThanOrEqualTo: dateStart)
        .where("timestamp", isLessThanOrEqualTo: dateEnd)
        .where("status", isEqualTo: "Need Update");
    var snapshot = await query.get();
    var count = snapshot.size;
    needUpdate = count;
  }

  Future<void> countNNU(Timestamp dateStart, Timestamp dateEnd) async {
    var query = firestore
        .collection("data")
        .where("timestamp", isGreaterThanOrEqualTo: dateStart)
        .where("timestamp", isLessThanOrEqualTo: dateEnd)
        .where("status", isEqualTo: "No Need Update");
    var snapshot = await query.get();
    var count = snapshot.size;
    noNeedUpdate = count;
  }

  Future<void> countT() async {
    var query = firestore
        .collection("data")
        .where("year", isEqualTo: DateTime.now().year);
    var snapshot = await query.get();
    var count = snapshot.size;
    totalData = count;
  }
}
