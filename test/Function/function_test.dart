import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:juling_apps/model/model.dart';
import 'package:juling_apps/model/model_maintenance.dart';
import 'package:juling_apps/service/firebase_service.dart';
import 'package:juling_apps/variable.dart';
import '../mock_cloud.dart';

final firestoreMock = FakeFirebaseFirestore();
void main() {
  group('fetchAndGenerateCSV', () {
    setupCloudFirestoreMocks();

    setUpAll(() async {
      await Firebase.initializeApp();
    });

    test('addData should increase 1 data', () async {
      final testData = InspectionData(
        date: "2023-10-12",
        number: "INS-2023-1",
        found: "Kaca Pecah",
        dueDate: "2023-10-15",
        progress: "Open",
        status: "Need Update",
        SPK: "100123",
        location: "Lantai 5",
        information: "SPK",
        linkBefore: "",
        linkAfter: "",
        timestamp: Timestamp.fromDate(DateTime.now()),
        year: 2023,
        category: "Others",
        pic: "Others",
        subCategory: "Others",
      );
      final collection = firestoreMock.collection("data");      
      final firebaseService = FirebaseService(firestore: firestoreMock);
      await firebaseService.addData(testData);
      final lengthData = (await collection.get()).docs.length;
      expect(lengthData, equals(1));      
    });

    test('updateData should change data', () async {
      final testData = InspectionData(
        date: "2023-10-12",
        number: "INS-2023-1",
        found: "Kaca Pecah",
        dueDate: "2023-10-15",
        progress: "Open",
        status: "Need Update",
        SPK: "100123",
        location: "Lantai 5",
        information: "SPK",
        linkBefore: "",
        linkAfter: "",
        timestamp: Timestamp.fromDate(DateTime.now()),
        year: 2023,
        category: "Others",
        pic: "Others",
        subCategory: "Others",
      );
      final newData = InspectionData(
        date: "2023-10-13",
        number: "INS-2023-1",
        found: "Kaca Pecah",
        dueDate: "2023-10-15",
        progress: "Open",
        status: "Need Update",
        SPK: "100123",
        location: "Lantai 5",
        information: "SPK",
        linkBefore: "",
        linkAfter: "",
        timestamp: Timestamp.fromDate(DateTime.now()),
        year: 2023,
        category: "Others",
        pic: "Others",
        subCategory: "Others",
      );
      const ID = "INS-2023-1";
      final collection = firestoreMock.collection("data");
      final document = collection.doc(ID);
      final firebaseService = FirebaseService(firestore: firestoreMock);
      await firebaseService.addData(testData);
      final firstData = (await document.get()).data();
      await firebaseService.updateData(ID, newData);
      final secondData = (await document.get()).data();
      expect(firstData, isNot(secondData));
    });

    test('addDataMaintenance should increase 1 data', () async {
      final testData = MaintenanceData(id: "NewID-01", spesifikasi: [], url: '');
      final collection = firestoreMock.collection("maintenance");
      final firebaseService = FirebaseService(firestore: firestoreMock);
      await firebaseService.addDataMaintenance(testData);
      final lengthData = (await collection.get()).docs.length;
      expect(lengthData, equals(1));      
    });

    test('updateDataMaintenance should change data', () async {
      final testData = MaintenanceData(id: "NewID-01", spesifikasi: [], url: '');
      final newData = MaintenanceData(id: "NewID-01", spesifikasi: ["spec1"], url: '');
      const ID = "NewID-01";
      final collection = firestoreMock.collection("maintenance");
      final document = collection.doc(ID);
      final firebaseService = FirebaseService(firestore: firestoreMock);
      await firebaseService.addDataMaintenance(testData);
      final firstData = (await document.get()).data();
      await firebaseService.updateDataMaintenance(ID, newData);
      final secondData = (await document.get()).data();
      expect(firstData, isNot(secondData));      
    });

    test('CountGT should count data', () async {
      final testData = InspectionData(
        date: "2023-10-12",
        number: "INS-2023-1",
        found: "Kaca Pecah",
        dueDate: "2023-10-15",
        progress: "Open",
        status: "Need Update",
        SPK: "100123",
        location: "Lantai 5",
        information: "SPK",
        linkBefore: "",
        linkAfter: "",
        timestamp: Timestamp.fromDate(DateTime(2023,10,15,0,0,0)),
        year: 2023,
        category: "Others",
        pic: "Others",
        subCategory: "Others",
      );
      final newData = InspectionData(
        date: "2023-10-13",
        number: "INS-2023-2",
        found: "Kaca Pecah",
        dueDate: "2023-10-15",
        progress: "Open",
        status: "Need Update",
        SPK: "100123",
        location: "Lantai 5",
        information: "SPK",
        linkBefore: "",
        linkAfter: "",
        timestamp: Timestamp.fromDate(DateTime(2023,10,20,0,0,0)),
        year: 2023,
        category: "Others",
        pic: "Others",
        subCategory: "Others",
      );
      final firebaseService = FirebaseService(firestore: firestoreMock);
      await firebaseService.addData(testData);
      await firebaseService.addData(newData);
      await firebaseService.countGT(Timestamp.fromDate(DateTime(2023,10,1,0,0,0)), Timestamp.fromDate(DateTime(2023,10,31,23,59,0)));      
      expect(grandTotal, equals(2));
    });

    test('CountMP should count data', () async {
      final testData = InspectionData(
        date: "2023-10-12",
        number: "INS-2023-1",
        found: "Kaca Pecah",
        dueDate: "2023-10-15",
        progress: "Open",
        status: "Need Update",
        SPK: "100123",
        location: "Lantai 5",
        information: "SPK",
        linkBefore: "",
        linkAfter: "",
        timestamp: Timestamp.fromDate(DateTime(2023,10,15,0,0,0)),
        year: 2023,
        category: "Others",
        pic: "Others",
        subCategory: "Others",
      );
      final newData = InspectionData(
        date: "2023-10-13",
        number: "INS-2023-2",
        found: "Kaca Pecah",
        dueDate: "2023-10-15",
        progress: "Material Preparation",
        status: "Need Update",
        SPK: "100123",
        location: "Lantai 5",
        information: "SPK",
        linkBefore: "",
        linkAfter: "",
        timestamp: Timestamp.fromDate(DateTime(2023,10,20,0,0,0)),
        year: 2023,
        category: "Others",
        pic: "Others",
        subCategory: "Others",
      );
      final firebaseService = FirebaseService(firestore: firestoreMock);
      await firebaseService.addData(testData);
      await firebaseService.addData(newData);
      await firebaseService.countMP(Timestamp.fromDate(DateTime(2023,10,1,0,0,0)), Timestamp.fromDate(DateTime(2023,10,31,23,59,0)));      
      expect(materialPrep, equals(1));
    });

    test('CountO should count data', () async {
      final testData = InspectionData(
        date: "2023-10-12",
        number: "INS-2023-1",
        found: "Kaca Pecah",
        dueDate: "2023-10-15",
        progress: "Open",
        status: "Need Update",
        SPK: "100123",
        location: "Lantai 5",
        information: "SPK",
        linkBefore: "",
        linkAfter: "",
        timestamp: Timestamp.fromDate(DateTime(2023,10,15,0,0,0)),
        year: 2023,
        category: "Others",
        pic: "Others",
        subCategory: "Others",
      );
      final newData = InspectionData(
        date: "2023-10-13",
        number: "INS-2023-2",
        found: "Kaca Pecah",
        dueDate: "2023-10-15",
        progress: "Material Preparation",
        status: "Need Update",
        SPK: "100123",
        location: "Lantai 5",
        information: "SPK",
        linkBefore: "",
        linkAfter: "",
        timestamp: Timestamp.fromDate(DateTime(2023,10,20,0,0,0)),
        year: 2023,
        category: "Others",
        pic: "Others",
        subCategory: "Others",
      );
      final firebaseService = FirebaseService(firestore: firestoreMock);
      await firebaseService.addData(testData);
      await firebaseService.addData(newData);
      await firebaseService.countO(Timestamp.fromDate(DateTime(2023,10,1,0,0,0)), Timestamp.fromDate(DateTime(2023,10,31,23,59,0)));      
      expect(open, equals(1));
    });

    test('CountC should count data', () async {
      final testData = InspectionData(
        date: "2023-10-12",
        number: "INS-2023-1",
        found: "Kaca Pecah",
        dueDate: "2023-10-15",
        progress: "Open",
        status: "Need Update",
        SPK: "100123",
        location: "Lantai 5",
        information: "SPK",
        linkBefore: "",
        linkAfter: "",
        timestamp: Timestamp.fromDate(DateTime(2023,10,15,0,0,0)),
        year: 2023,
        category: "Others",
        pic: "Others",
        subCategory: "Others",
      );
      final newData = InspectionData(
        date: "2023-10-13",
        number: "INS-2023-2",
        found: "Kaca Pecah",
        dueDate: "2023-10-15",
        progress: "Completed",
        status: "Need Update",
        SPK: "100123",
        location: "Lantai 5",
        information: "SPK",
        linkBefore: "",
        linkAfter: "",
        timestamp: Timestamp.fromDate(DateTime(2023,10,20,0,0,0)),
        year: 2023,
        category: "Others",
        pic: "Others",
        subCategory: "Others",
      );
      final firebaseService = FirebaseService(firestore: firestoreMock);
      await firebaseService.addData(testData);
      await firebaseService.addData(newData);
      await firebaseService.countC(Timestamp.fromDate(DateTime(2023,10,1,0,0,0)), Timestamp.fromDate(DateTime(2023,10,31,23,59,0)));      
      expect(completed, equals(1));
    });

    test('CountPC should count data', () async {
      final testData = InspectionData(
        date: "2023-10-12",
        number: "INS-2023-1",
        found: "Kaca Pecah",
        dueDate: "2023-10-15",
        progress: "Open",
        status: "Need Update",
        SPK: "100123",
        location: "Lantai 5",
        information: "SPK",
        linkBefore: "",
        linkAfter: "",
        timestamp: Timestamp.fromDate(DateTime(2023,10,15,0,0,0)),
        year: 2023,
        category: "Others",
        pic: "Others",
        subCategory: "Others",
      );
      final newData = InspectionData(
        date: "2023-10-13",
        number: "INS-2023-2",
        found: "Kaca Pecah",
        dueDate: "2023-10-15",
        progress: "Progress Construction",
        status: "Need Update",
        SPK: "100123",
        location: "Lantai 5",
        information: "SPK",
        linkBefore: "",
        linkAfter: "",
        timestamp: Timestamp.fromDate(DateTime(2023,10,20,0,0,0)),
        year: 2023,
        category: "Others",
        pic: "Others",
        subCategory: "Others",
      );
      final firebaseService = FirebaseService(firestore: firestoreMock);
      await firebaseService.addData(testData);
      await firebaseService.addData(newData);
      await firebaseService.countPC(Timestamp.fromDate(DateTime(2023,10,1,0,0,0)), Timestamp.fromDate(DateTime(2023,10,31,23,59,0)));      
      expect(progressCons, equals(1));
    });

    test('CountNU should count data', () async {
      final testData = InspectionData(
        date: "2023-10-12",
        number: "INS-2023-1",
        found: "Kaca Pecah",
        dueDate: "2023-10-15",
        progress: "Open",
        status: "Need Update",
        SPK: "100123",
        location: "Lantai 5",
        information: "SPK",
        linkBefore: "",
        linkAfter: "",
        timestamp: Timestamp.fromDate(DateTime(2023,10,15,0,0,0)),
        year: 2023,
        category: "Others",
        pic: "Others",
        subCategory: "Others",
      );
      final newData = InspectionData(
        date: "2023-10-13",
        number: "INS-2023-2",
        found: "Kaca Pecah",
        dueDate: "2023-10-15",
        progress: "Material Preparation",
        status: "Need Update",
        SPK: "100123",
        location: "Lantai 5",
        information: "SPK",
        linkBefore: "",
        linkAfter: "",
        timestamp: Timestamp.fromDate(DateTime(2023,10,20,0,0,0)),
        year: 2023,
        category: "Others",
        pic: "Others",
        subCategory: "Others",
      );
      final firebaseService = FirebaseService(firestore: firestoreMock);
      await firebaseService.addData(testData);
      await firebaseService.addData(newData);
      await firebaseService.countNU(Timestamp.fromDate(DateTime(2023,10,1,0,0,0)), Timestamp.fromDate(DateTime(2023,10,31,23,59,0)));      
      expect(needUpdate, equals(2));
    });

    test('CountNNU should count data', () async {
      final testData = InspectionData(
        date: "2023-10-12",
        number: "INS-2023-1",
        found: "Kaca Pecah",
        dueDate: "2023-10-15",
        progress: "Open",
        status: "Need Update",
        SPK: "100123",
        location: "Lantai 5",
        information: "SPK",
        linkBefore: "",
        linkAfter: "",
        timestamp: Timestamp.fromDate(DateTime(2023,10,15,0,0,0)),
        year: 2023,
        category: "Others",
        pic: "Others",
        subCategory: "Others",
      );
      final newData = InspectionData(
        date: "2023-10-13",
        number: "INS-2023-2",
        found: "Kaca Pecah",
        dueDate: "2023-10-15",
        progress: "Material Preparation",
        status: "Need Update",
        SPK: "100123",
        location: "Lantai 5",
        information: "SPK",
        linkBefore: "",
        linkAfter: "",
        timestamp: Timestamp.fromDate(DateTime(2023,10,20,0,0,0)),
        year: 2023,
        category: "Others",
        pic: "Others",
        subCategory: "Others",
      );
      final firebaseService = FirebaseService(firestore: firestoreMock);
      await firebaseService.addData(testData);
      await firebaseService.addData(newData);
      await firebaseService.countNNU(Timestamp.fromDate(DateTime(2023,10,1,0,0,0)), Timestamp.fromDate(DateTime(2023,10,31,23,59,0)));      
      expect(noNeedUpdate, equals(0));
    });

    test('CountT should count data', () async {
      final testData = InspectionData(
        date: "2023-10-12",
        number: "INS-2023-1",
        found: "Kaca Pecah",
        dueDate: "2023-10-15",
        progress: "Open",
        status: "Need Update",
        SPK: "100123",
        location: "Lantai 5",
        information: "SPK",
        linkBefore: "",
        linkAfter: "",
        timestamp: Timestamp.fromDate(DateTime(2023,10,15,0,0,0)),
        year: DateTime.now().year,
        category: "Others",
        pic: "Others",
        subCategory: "Others",
      );
      final newData = InspectionData(
        date: "2023-10-13",
        number: "INS-2023-2",
        found: "Kaca Pecah",
        dueDate: "2023-10-15",
        progress: "Material Preparation",
        status: "Need Update",
        SPK: "100123",
        location: "Lantai 5",
        information: "SPK",
        linkBefore: "",
        linkAfter: "",
        timestamp: Timestamp.fromDate(DateTime(2023,10,20,0,0,0)),
        year: DateTime.now().year,
        category: "Others",
        pic: "Others",
        subCategory: "Others",
      );
      final firebaseService = FirebaseService(firestore: firestoreMock);
      await firebaseService.addData(testData);
      await firebaseService.addData(newData);
      await firebaseService.countT();      
      expect(totalData, equals(2));
    });
  });
}
