import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:juling_apps/model/model_maintenance.dart';
import 'package:juling_apps/service/firebase_service.dart';

class EditMaintenanceProvider extends ChangeNotifier {
  String barcode = 'Pindai QR untuk mendapatkan data';
  List<String> spesifikasi = [];
  List<TextEditingController> controllers = [];
  bool isSaving = false;
  bool mounted = true;
  bool exist = false;
  final FirebaseService firebaseService;
  EditMaintenanceProvider({required this.firebaseService});

  @override
  void dispose() {
    mounted = false;
    super.dispose();
  }

  void reset() {
    barcode = "Pindai QR untuk mendapatkan data";
    exist = false;
    notifyListeners();
  }

  Future<void> fetchValues() async {
    final snapshot =
        await firebaseService.firestore.collection("maintenance").doc(barcode).get();    
    if (snapshot.exists) {
      final data = snapshot.data();
      final length = data!['Spesifikasi'].length;
      spesifikasi =
          List<String>.generate(length, (index) => data['Spesifikasi'][index]);
      controllers = List.generate(length, (_) => TextEditingController());
      for (var i = 0; i < length; i++) {
        controllers[i].text = data['Spesifikasi'][i];
      }
      exist = true;
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: "Data tidak ada");
    }
    notifyListeners();
  }

  void updateValue(int index, String newValue, MaintenanceData data) {
    spesifikasi[index] = newValue;
    notifyListeners();
    saveChanges(data);
    notifyListeners();
  }

  void addValue() {
    spesifikasi.add('');
    controllers.add(TextEditingController());
    notifyListeners();
  }

  Future<void> deleteValue(int index) async {
    spesifikasi.removeAt(index);
    controllers.removeAt(index);
    notifyListeners();
    await firebaseService.firestore.collection("maintenance")
        .doc(barcode)
        .update({'Spesifikasi': spesifikasi});
  }

  Future<void> saveChanges(MaintenanceData data) async {
    if (!mounted) {
      return;
    }
    isSaving = true;
    notifyListeners();
    await firebaseService.updateDataMaintenance(barcode, data);
    if (!mounted) {
      return;
    }
    isSaving = false;
    notifyListeners();
  }

  void scanBarcode() async {
    try {
      exist = false;
      notifyListeners();
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      if (!mounted) {
        return;
      }
      barcode = qrCode;
      notifyListeners();
      if (barcode != "-1") {
        fetchValues();
      }
    } on PlatformException {
      barcode = "Gagal dalam memindai QR code";
      notifyListeners();
    }
  }
}
