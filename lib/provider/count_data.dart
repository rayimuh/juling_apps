import 'package:juling_apps/service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CountDataProvider extends ChangeNotifier {
  final FirebaseService firebaseService;

  CountDataProvider({required this.firebaseService});

  Future<void> countGT(Timestamp dateStart, Timestamp dateEnd) async {
    await firebaseService.countGT(dateStart,dateEnd);
    notifyListeners();
  }
  
  Future<void> countNNU(Timestamp dateStart, Timestamp dateEnd) async {
    await firebaseService.countNNU(dateStart,dateEnd);
    notifyListeners();
  }

  Future<void> countC(Timestamp dateStart, Timestamp dateEnd) async {
    await firebaseService.countC(dateStart,dateEnd);
    notifyListeners();
  }
  
  Future<void> countMP(Timestamp dateStart, Timestamp dateEnd) async {
    await firebaseService.countMP(dateStart,dateEnd);
    notifyListeners();
  }
  
  Future<void> countNU(Timestamp dateStart, Timestamp dateEnd) async {
    await firebaseService.countNU(dateStart,dateEnd);
    notifyListeners();
  }

  Future<void> countO(Timestamp dateStart, Timestamp dateEnd) async {
    await firebaseService.countO(dateStart,dateEnd);
    notifyListeners();
  }

  Future<void> countT() async {
    await firebaseService.countT();
    notifyListeners();
  }

  Future<void> countPC(Timestamp dateStart, Timestamp dateEnd) async {
    await firebaseService.countPC(dateStart,dateEnd);
    notifyListeners();
  }
  }