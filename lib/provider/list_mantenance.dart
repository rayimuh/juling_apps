import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:juling_apps/model/model_maintenance.dart';


class MaintenanceDataProvider with ChangeNotifier { 
final FirebaseFirestore firestore;
MaintenanceDataProvider({required this.firestore});
  Stream<List<MaintenanceData>> getMaintenanceData() {
    return firestore
        .collection('maintenance')
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => MaintenanceData(
                  id: doc.id,
                  spesifikasi: List<String>.from(doc.data()['Spesifikasi']),
                  url: doc.data()['Gambar']
                ))
            .toList());
  }
}