import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:juling_apps/service/firebase_service.dart';
import 'package:juling_apps/model/model.dart';

class AddDataProvider with ChangeNotifier {
  final FirebaseService firebaseService;

  AddDataProvider({required this.firebaseService});

  Future<void> addData(InspectionData data) async {
    await firebaseService.addData(data);
    notifyListeners();
    Fluttertoast.showToast(msg: "Data berhasil diupdate");
  }
}
