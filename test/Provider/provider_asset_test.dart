import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:juling_apps/provider/add_data.dart';
import 'package:juling_apps/provider/count_data.dart';
import 'package:juling_apps/provider/edit_data.dart';
import 'package:juling_apps/provider/list_data.dart';
import 'package:juling_apps/service/firebase_service.dart';
import 'package:juling_apps/model/model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

import '../mock_cloud.dart';
import 'provider_asset_test.mocks.dart';

final firestore = FakeFirebaseFirestore();

@GenerateMocks([FirebaseService])
void main() {
  group('Asset Provider', () {
    late CountDataProvider countDataProvider;
    late MockFirebaseService mockFirebaseService;
    late EditDataProvider editDataProvider;
    late ListDataProvider listDataProvider;

    setupCloudFirestoreMocks();

    setUpAll(() async {
      await Firebase.initializeApp();
    });

    setUp(() {
      listDataProvider = ListDataProvider(firestore: firestore);
      mockFirebaseService = MockFirebaseService();
      countDataProvider =
          CountDataProvider(firebaseService: mockFirebaseService);
      editDataProvider = EditDataProvider(firebaseService: mockFirebaseService);
    });

    test('addData should call FirebaseService', () async {
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
      final mockFirebaseService = MockFirebaseService();
      final addDataProvider =
          AddDataProvider(firebaseService: mockFirebaseService);
      when(mockFirebaseService.addData(testData))
          .thenAnswer((_) => Future.value());
      await addDataProvider.addData(testData);
      verify(mockFirebaseService.addData(testData)).called(1);
    });

    test('countGT should call the corresponding method in FirebaseService',
        () async {
      final dateStart = Timestamp.fromDate(DateTime(2023, 1, 1));
      final dateEnd = Timestamp.fromDate(DateTime(2023, 12, 31));
      await countDataProvider.countGT(dateStart, dateEnd);
      verify(mockFirebaseService.countGT(dateStart, dateEnd)).called(1);
    });

    test('countNNU should call the corresponding method in FirebaseService',
        () async {
      final dateStart = Timestamp.fromDate(DateTime(2023, 1, 1));
      final dateEnd = Timestamp.fromDate(DateTime(2023, 12, 31));
      await countDataProvider.countNNU(dateStart, dateEnd);
      verify(mockFirebaseService.countNNU(dateStart, dateEnd)).called(1);
    });

    test('countC should call the corresponding method in FirebaseService',
        () async {
      final dateStart = Timestamp.fromDate(DateTime(2023, 1, 1));
      final dateEnd = Timestamp.fromDate(DateTime(2023, 12, 31));
      await countDataProvider.countC(dateStart, dateEnd);
      verify(mockFirebaseService.countC(dateStart, dateEnd)).called(1);
    });

    test('countMP should call the corresponding method in FirebaseService',
        () async {
      final dateStart = Timestamp.fromDate(DateTime(2023, 1, 1));
      final dateEnd = Timestamp.fromDate(DateTime(2023, 12, 31));
      await countDataProvider.countMP(dateStart, dateEnd);
      verify(mockFirebaseService.countMP(dateStart, dateEnd)).called(1);
    });

    test('countNU should call the corresponding method in FirebaseService',
        () async {
      final dateStart = Timestamp.fromDate(DateTime(2023, 1, 1));
      final dateEnd = Timestamp.fromDate(DateTime(2023, 12, 31));
      await countDataProvider.countNU(dateStart, dateEnd);
      verify(mockFirebaseService.countNU(dateStart, dateEnd)).called(1);
    });

    test('countO should call the corresponding method in FirebaseService',
        () async {
      final dateStart = Timestamp.fromDate(DateTime(2023, 1, 1));
      final dateEnd = Timestamp.fromDate(DateTime(2023, 12, 31));
      await countDataProvider.countO(dateStart, dateEnd);
      verify(mockFirebaseService.countO(dateStart, dateEnd)).called(1);
    });

    test('countT should call the corresponding method in FirebaseService',
        () async {
      await countDataProvider.countT();
      verify(mockFirebaseService.countT()).called(1);
    });

    test('countPC should call the corresponding method in FirebaseService',
        () async {
      final dateStart = Timestamp.fromDate(DateTime(2023, 1, 1));
      final dateEnd = Timestamp.fromDate(DateTime(2023, 12, 31));
      await countDataProvider.countPC(dateStart, dateEnd);
      verify(mockFirebaseService.countPC(dateStart, dateEnd)).called(1);
    });

    test('updateData should call the corresponding method in FirebaseService',
        () async {
      const docId = 'INS-2023-1';
      final newData = InspectionData(
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
      await editDataProvider.updateData(docId, newData);
      verify(mockFirebaseService.updateData(docId, newData)).called(1);
    });

    test('getDataList should return a list of InspectionData', () {
      // Define your sample data and add it to the Firestore mock
      final sampleData = <Map<String, dynamic>>[
        {
          'date': Timestamp.fromDate(DateTime(2023, 1, 1)),
          'number': '123',
          'found': 'Found',
          'dueDate': '2023-02-15',
          'progress': 'In Progress',
          'status': 'Open',
          'no SPK': 'SPK123',
          'location': 'Location A',
          'information': 'Some information',
          'link before': 'link_before.jpg',
          'link after': 'link_after.jpg',
          'year': 2023,
          'pic': 'John Doe',
          'category': 'Category A',
          'sub-category': 'Subcategory 1',
        },
        {
          'date': Timestamp.fromDate(DateTime(2023, 2, 15)),
          'number': '124',
          'found': 'Not Found',
          'dueDate': '2023-03-10',
          'progress': 'Completed',
          'status': 'Closed',
          'no SPK': 'SPK124',
          'location': 'Location B',
          'information': 'Additional information',
          'link before': 'link_before_2.jpg',
          'link after': 'link_after_2.jpg',
          'year': 2023,
          'pic': 'Jane Smith',
          'category': 'Category B',
          'sub-category': 'Subcategory 2',
        },
      ];
      for (final data in sampleData) {
        firestore.collection('data').add(data);
      }
      final dataList = listDataProvider.getDataList();
      expect(dataList, isNotNull);
      expect(dataList, isA<Stream<List<InspectionData>>>());
    });

    test('filterData should return a list of filtered InspectionData', () {
      final sampleData = <Map<String, dynamic>>[
        {
          'date': Timestamp.fromDate(DateTime(2023, 1, 1)),
          'number': '123',
          'found': 'Found',
          'dueDate': '2023-02-15',
          'progress': 'In Progress',
          'status': 'Open',
          'no SPK': 'SPK123',
          'location': 'Location A',
          'information': 'Some information',
          'link before': 'link_before.jpg',
          'link after': 'link_after.jpg',
          'year': 2023,
          'pic': 'John Doe',
          'category': 'Category A',
          'sub-category': 'Subcategory 1',
        },
        {
          'date': Timestamp.fromDate(DateTime(2023, 2, 15)),
          'number': '124',
          'found': 'Not Found',
          'dueDate': '2023-03-10',
          'progress': 'Completed',
          'status': 'Closed',
          'no SPK': 'SPK124',
          'location': 'Location B',
          'information': 'Additional information',
          'link before': 'link_before_2.jpg',
          'link after': 'link_after_2.jpg',
          'year': 2023,
          'pic': 'Jane Smith',
          'category': 'Category B',
          'sub-category': 'Subcategory 2',
        },
      ];
      for (final data in sampleData) {
        firestore.collection('data').add(data);
      }
      final dateStart = Timestamp.fromDate(DateTime(2023, 1, 1));
      final dateEnd = Timestamp.fromDate(DateTime(2023, 2, 15));
      const progress = 'In Progress';
      const status = 'Open';
      const SPK = 'SPK123';
      const number = '123';
      const completedOrNot = 'Completed';
      const category = 'Category A';
      const pic = 'John Doe';
      final filteredDataList = listDataProvider.filterData(dateStart, dateEnd,
          progress, status, SPK, number, completedOrNot, category, pic);
      expect(filteredDataList, isNotNull);
      expect(filteredDataList, isA<Stream<List<InspectionData>>>());
    });
  });
}
