import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:juling_apps/provider/add_maintenance.dart';
import 'package:juling_apps/model/model_maintenance.dart';
import 'package:juling_apps/provider/edit_maintenance.dart';
import 'package:juling_apps/provider/list_mantenance.dart';
import 'package:juling_apps/service/firebase_service.dart';

import '../mock_cloud.dart';
final firestoreMock = FakeFirebaseFirestore();
void main() {
  group('Maintenance Provider', () {
    setupCloudFirestoreMocks();

    setUpAll(() async {
      await Firebase.initializeApp();
    });
    late AddMaintenanceProvider addMaintenanceProvider;    
    late EditMaintenanceProvider editMaintenanceProvider;
    late MaintenanceDataProvider maintenanceDataProvider;

    setUp(() {      
      editMaintenanceProvider =
          EditMaintenanceProvider(firebaseService: FirebaseService(firestore: firestoreMock));
      addMaintenanceProvider =
          AddMaintenanceProvider(firebaseService: FirebaseService(firestore: firestoreMock));
      maintenanceDataProvider = MaintenanceDataProvider(firestore: firestoreMock);
    });

    test('changeId should update the id', () {
      const newId = 'NewID-01';
      addMaintenanceProvider.changeId(newId);
      expect(addMaintenanceProvider.id, newId);
    });

    test('updateValue should update the value at the specified index', () {
      const index = 0;
      const newValue = '15 PK';
      addMaintenanceProvider.spesifikasi.add('10 PK');
      addMaintenanceProvider.updateValue(index, newValue);
      expect(addMaintenanceProvider.spesifikasi[index], newValue);
    });

    test('reset should clear controllers, spesifikasi, and id', () {
      addMaintenanceProvider.reset();
      expect(addMaintenanceProvider.controllers, isEmpty);
      expect(addMaintenanceProvider.spesifikasi, isEmpty);
      expect(addMaintenanceProvider.id, isEmpty);
    });

    test('addValue should add a new value', () {
      final initialLength = addMaintenanceProvider.spesifikasi.length;
      addMaintenanceProvider.addValue();
      expect(addMaintenanceProvider.spesifikasi.length, initialLength + 1);
    });

    test('deleteValue should remove the value at the specified index', () {
      addMaintenanceProvider.addValue();
      final initialLength = addMaintenanceProvider.spesifikasi.length;
      const index = 0;
      addMaintenanceProvider.deleteValue(index);
      expect(addMaintenanceProvider.spesifikasi.length, initialLength - 1);
    });

    test('isSaving is false at the end of SaveChanges function', () async {
      final data =
          MaintenanceData(id: 'NewID-01', spesifikasi: ["15 PK"], url: '');
      await addMaintenanceProvider.saveChanges(data);
      expect(addMaintenanceProvider.isSaving, false);
    });

    test('Reset should reset the values', () {
      editMaintenanceProvider.reset();
      expect(
          editMaintenanceProvider.barcode, 'Pindai QR untuk mendapatkan data');
      expect(editMaintenanceProvider.exist, isFalse);
    });

    test('UpdateValue should update spesifikasi', () async{
      editMaintenanceProvider.barcode = 'NewID-01';
      editMaintenanceProvider.spesifikasi = ['Spec1', 'Spec2'];
      final newData = MaintenanceData(
          id: 'NewID-01', spesifikasi: ['NewSpec1', 'NewSpec2'], url: '');
      await firestoreMock.collection("maintenance").doc(editMaintenanceProvider.barcode).set(newData.toMap());
      editMaintenanceProvider.updateValue(0, 'NewSpec1', newData);
      expect(editMaintenanceProvider.spesifikasi, ['NewSpec1', 'Spec2']);
      expect(editMaintenanceProvider.isSaving, isTrue);
    });

    test(
        'AddValue should add an empty string to spesifikasi and a new TextEditingController',
        () {
      editMaintenanceProvider.addValue();
      expect(editMaintenanceProvider.spesifikasi, hasLength(1));
      expect(editMaintenanceProvider.spesifikasi.first, '');
      expect(editMaintenanceProvider.controllers, hasLength(1));
      expect(editMaintenanceProvider.controllers.first.text, '');
    });

    test(
        'DeleteValue should remove the item at the specified index from spesifikasi and controllers',
        () async {
      editMaintenanceProvider.barcode = "NewID-01";      
      final collection = firestoreMock.collection("maintenance");
      final document = collection.doc("NewID-01");
      final data = {
        'id': 'NewID-01',
        'Spesifikasi': ['Spec1', 'Spec2', 'Spec3'],
        'Gambar': 'url1',
      };
      await document.set(data);
      editMaintenanceProvider.spesifikasi = ['Spec1', 'Spec2', 'Spec3'];
      editMaintenanceProvider.controllers = [
        TextEditingController(text: 'Spec1'),
        TextEditingController(text: 'Spec2'),
        TextEditingController(text: 'Spec3'),
      ];      
      await editMaintenanceProvider.deleteValue(1);
      expect(editMaintenanceProvider.spesifikasi, ['Spec1', 'Spec3']);
      expect(editMaintenanceProvider.controllers, hasLength(2));
      expect(editMaintenanceProvider.controllers[0].text, 'Spec1');
      expect(editMaintenanceProvider.controllers[1].text, 'Spec3');
    });
    
    test(
        'FetchValues should add the item to spesifikasi and controllers',
        () async {
      editMaintenanceProvider.barcode = "NewID-01";      
      final collection = firestoreMock.collection("maintenance");
      final document = collection.doc("NewID-01");
      final data = {
        'id': 'NewID-01',
        'Spesifikasi': ['Spec1', 'Spec2', 'Spec3'],
        'Gambar': 'url1',
      };
      await document.set(data);         
      await editMaintenanceProvider.fetchValues();
      expect(editMaintenanceProvider.spesifikasi, ['Spec1', 'Spec2', 'Spec3']);
      expect(editMaintenanceProvider.controllers, hasLength(3));     
    });

    test('getMaintenanceData should return a list of filtered MaintenanceData', () async {      
      final collection = firestoreMock.collection("maintenance");
      final document = collection.doc("NewID-01");
      final data = {
        'id': 'NewID-01',
        'Spesifikasi': ['Spec1', 'Spec2', 'Spec3'],
        'Gambar': 'url1',
      };      
      await document.set(data); 
      final dataMaintenance = maintenanceDataProvider.getMaintenanceData();                           
      expect(dataMaintenance, isNotNull);
      expect(dataMaintenance, isA<Stream<List<MaintenanceData>>>());
    });
  });
}
