// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:juling_apps/model/model.dart';

class ListDataProvider with ChangeNotifier {  
  final FirebaseFirestore firestore;

  ListDataProvider({required this.firestore});

  Stream<List<InspectionData>> getDataList() {
    return firestore.collection('data').snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return InspectionData(
            date: doc['date'],
            number: doc['number'],
            found: doc['found'],
            dueDate: doc['dueDate'],
            progress: doc['progress'],
            status: doc['status'],
            SPK: doc['no SPK'],
            location: doc['location'],
            information: doc['information'],
            linkBefore: doc['link before'],
            linkAfter: doc['link after'],
            timestamp: doc['timestamp'],
            year: doc.data().toString().contains('year')?doc["year"]:DateTime.now().year,
            pic: doc.data().toString().contains('pic')?doc["pic"]:"Others",
            category: doc.data().toString().contains('category')?doc["category"]:"Others",
            subCategory: doc.data().toString().contains('sub-category')?doc["sub-category"]:"Others");
      }).toList();
    });
  }

  Stream<List<InspectionData>> filterData(
    Timestamp? dateStart,
    Timestamp? dateEnd,
    String? progress,
    String? status,
    String? SPK,
    String? number,
    String? completedOrNot,
    String? category,
    String? pic
  ) {
    Query<Map<String, dynamic>> query = firestore.collection("data");

    if (dateStart != null) {
      query = query.where("timestamp", isGreaterThanOrEqualTo: dateStart);
    }
    if (dateEnd != null) {
      query = query.where("timestamp", isLessThanOrEqualTo: dateEnd);
    }
    if (progress != null) {
      query = query.where("progress", isEqualTo: progress);
    }
    if (status != null) {
      query = query.where("status", isEqualTo: status);
    }
    if (category != null) {
      query = query.where("category", isEqualTo: category);
    }
    if (pic != null) {
      query = query.where("pic", isEqualTo: pic);
    }
    if (SPK!.isNotEmpty) {
      query = query.where("no SPK", isEqualTo: SPK);
    }
    if (number!.isNotEmpty) {
      query = query.where("number", isEqualTo: number.toUpperCase());
    }    
    if(completedOrNot=="Completed"){
      query = query.where("progress", isEqualTo: "Completed");
    }
    

    return query.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return InspectionData(
            date: doc['date'],
            number: doc['number'],
            found: doc['found'],
            dueDate: doc['dueDate'],
            progress: doc['progress'],
            status: doc['status'],
            SPK: doc['no SPK'],
            location: doc['location'],
            information: doc['information'],
            linkBefore: doc['link before'],
            linkAfter: doc['link after'],
            timestamp: doc['timestamp'],
            year: doc.data().toString().contains('year')?doc["year"]:DateTime.now().year,
            pic: doc.data().toString().contains('pic')?doc["pic"]:"Others",
            category: doc.data().toString().contains('category')?doc["category"]:"Others",
            subCategory: doc.data().toString().contains('sub-category')?doc["sub-category"]:"Others");
      }).toList();
    });
  }
}
