import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:juling_apps/model/model_maintenance.dart';
import 'package:juling_apps/service/firebase_service.dart';

class AddMaintenanceProvider extends ChangeNotifier {
  List<String> spesifikasi = [];
  List<TextEditingController> controllers = [];
  bool isSaving = false;
  bool mounted = true;
  String id = "";
  final FirebaseService firebaseService;
  AddMaintenanceProvider({required this.firebaseService});
  
  @override
  void dispose() {
    mounted = false;
    super.dispose();
  }

  void changeId(String newId) {
    id = newId;
    notifyListeners();
  }

  void updateValue(int index, String newValue) {
    spesifikasi[index] = newValue;       
    notifyListeners();
  }

  void reset() {
    controllers.clear();
    spesifikasi.clear();
    id = '';
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
  }

  Future<void> saveChanges(MaintenanceData data) async {
    if (id != '' || id.isNotEmpty) {
      if (!mounted) {
        return;
      }
      isSaving = true;
      notifyListeners();
      
      await firebaseService.addDataMaintenance(data);
      if (!mounted) {
        return;
      }
      isSaving = false;
      Fluttertoast.showToast(msg: "Data berhasil diupload");
      notifyListeners();
    }
  }
}
