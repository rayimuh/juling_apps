import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:juling_apps/model/model.dart';

void main() {
  group('InspectionData Tests', () {
    test('Construction should work correctly', () {
      final inspectionData = InspectionData(
        date: '2023-10-20',
        number: '12345',
        found: 'Found issue',
        dueDate: '2023-11-30',
        progress: 'In progress',
        status: 'Open',
        SPK: 'SPK123',
        location: 'Location XYZ',
        information: 'Some information',
        linkBefore: 'before_image_url',
        linkAfter: 'after_image_url',
        timestamp: Timestamp.now(),
        year: 2023,
        category: 'Category',
        pic: 'John Doe',
        subCategory: 'Sub-Category',
      );

      expect(inspectionData.date, '2023-10-20');
      expect(inspectionData.number, '12345');
      expect(inspectionData.found, 'Found issue');
      expect(inspectionData.dueDate, '2023-11-30');
      expect(inspectionData.progress, 'In progress');
      expect(inspectionData.status, 'Open');
      expect(inspectionData.SPK, 'SPK123');
      expect(inspectionData.location, 'Location XYZ');
      expect(inspectionData.information, 'Some information');
      expect(inspectionData.linkBefore, 'before_image_url');
      expect(inspectionData.linkAfter, 'after_image_url');
      expect(inspectionData.year, 2023);
      expect(inspectionData.category, 'Category');
      expect(inspectionData.pic, 'John Doe');
      expect(inspectionData.subCategory, 'Sub-Category');
    });

    test('toMap should convert to the correct map', () {
      final inspectionData = InspectionData(
        date: '2023-10-20',
        number: '12345',
        found: 'Found issue',
        dueDate: '2023-11-30',
        progress: 'In progress',
        status: 'Open',
        SPK: 'SPK123',
        location: 'Location XYZ',
        information: 'Some information',
        linkBefore: 'before_image_url',
        linkAfter: 'after_image_url',
        timestamp: Timestamp.now(),
        year: 2023,
        category: 'Category',
        pic: 'John Doe',
        subCategory: 'Sub-Category',
      );

      final expectedMap = {
        'date': '2023-10-20',
        'number': '12345',
        'found': 'Found issue',
        'dueDate': '2023-11-30',
        'progress': 'In progress',
        'status': 'Open',
        'no SPK': 'SPK123',
        'location': 'Location XYZ',
        'information': 'Some information',
        'link before': 'before_image_url',
        'link after': 'after_image_url',
        'year': 2023,
        'pic': 'John Doe',
        'category': 'Category',
        'sub-category': 'Sub-Category',
      };

      expect(inspectionData.toMap(), expectedMap);
    });
  });
}
