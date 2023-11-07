// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class InspectionData {
  String date;
  String number;
  String found;
  String? dueDate;
  String progress;
  String status;
  String? SPK;
  String location;
  String information;
  String? linkBefore;
  String? linkAfter;
  Timestamp timestamp;
  int year;
  String pic;
  String category;
  String subCategory;

  InspectionData({
    required this.date,
    required this.number,
    required this.found,
    required this.dueDate,
    required this.progress,
    required this.status,
    required this.SPK,
    required this.location,
    required this.information,
    required this.linkBefore,
    required this.linkAfter,
    required this.timestamp,
    required this.year,
    required this.category,
    required this.pic,
    required this.subCategory
  });
    Map<String, dynamic> toMap() {
    return {
      'date': date,
      'number': number,
      'found': found,
      'dueDate': dueDate,
      'progress': progress,
      'status': status,
      'no SPK': SPK,
      'location': location,
      'information': information,
      'link before': linkBefore,
      'link after': linkAfter,
      "year": year,
      "pic":pic,
      "category":category,
      "sub-category":subCategory
    };
  }
}
