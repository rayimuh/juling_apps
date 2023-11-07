import 'package:fluttertoast/fluttertoast.dart';
import 'package:juling_apps/service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:juling_apps/model/model.dart';

class EditDataProvider extends ChangeNotifier {
  final FirebaseService firebaseService;

  EditDataProvider({required this.firebaseService});

  Future<void> updateData(String docId, InspectionData newData) async {
    await firebaseService.updateData(docId, newData);    
    notifyListeners();
    Fluttertoast.showToast(msg: "Data berhasil di update");
  }}