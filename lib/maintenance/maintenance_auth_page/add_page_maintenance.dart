// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:juling_apps/model/model_maintenance.dart';
import 'package:juling_apps/provider/add_maintenance.dart';
import 'package:juling_apps/variable.dart';

class AddDataMaintenance extends StatefulWidget {
  const AddDataMaintenance({super.key});

  @override
  State<AddDataMaintenance> createState() => _AddDataMaintenanceState();
}

class _AddDataMaintenanceState extends State<AddDataMaintenance> {
  TextEditingController id = TextEditingController();
  Future<String> uploadImage(String imageName) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await showDialog<XFile>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Pilih sumber gambar"),
        actions: [
          TextButton(
            onPressed: () async {
              final image = await picker.pickImage(
                source: ImageSource.camera,
                imageQuality: 5,
              );
              Navigator.pop(context, image);
            },
            child: const Text("Kamera"),
          ),
          TextButton(
            onPressed: () async {
              final image = await picker.pickImage(
                source: ImageSource.gallery,
                imageQuality: 5,
              );
              Navigator.pop(context, image);
            },
            child: const Text("Galeri"),
          ),
        ],
      ),
    );

    if (image != null) {
      Reference ref = FirebaseStorage.instance.ref().child("$imageName.jpg");
      await ref.putFile(File(image.path));

      return ref.getDownloadURL();
    }

    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            bottomOpacity: 0.0,
            elevation: 0.0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                final value =
                    Provider.of<AddMaintenanceProvider>(context, listen: false);
                value.reset();
                id.clear();
                Navigator.pop(context);
              },
            )),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF394B78),
          onPressed: () {
            final value =
                Provider.of<AddMaintenanceProvider>(context, listen: false);
            value.addValue();
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: Consumer<AddMaintenanceProvider>(
          builder: (context, value, child) {
            return Stack(
              children: [
                SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: SvgPicture.asset(
                    "assets/add_report.svg",
                    fit: BoxFit.fill,
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'ID Perangkat',
                            filled: true,
                            fillColor: Colors.white,
                            labelStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          controller: id,
                          onChanged: (_){
                            setState(() {                              
                            });
                          },
                        ),
                      ),
                      InkWell(
                        onTap:id.text==''
                        ?null
                        :() async {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              });

                          final String imageDestination =
                              await uploadImage(id.text);

                          Navigator.of(context).pop();
                          setState(() {
                            maintenanceBefore = imageDestination;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          height: 200,
                          width: double.infinity,
                          child: Card(
                            child: Center(
                              child: maintenanceBefore != ""
                                  ? Image.network(maintenanceBefore)
                                  : const Center(
                                      child: Text(
                                          'Klik untuk tambah foto perangkat'),
                                    ),
                            ),
                          ),
                        ),
                      ),
                      for (int i = 0; i < value.spesifikasi.length; i++)
                        Dismissible(
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            Provider.of<AddMaintenanceProvider>(context,
                                    listen: false)
                                .deleteValue(i);
                          },
                          child: Container(
                            margin: const EdgeInsets.all(20),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Spesifikasi ${i + 1}',
                                filled: true,
                                fillColor: Colors.white,
                                labelStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              controller: value.controllers[i],
                            ),
                          ),
                        ),                      
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF394B78),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80),
                          ),
                        ),
                        onPressed: value.isSaving
                            ? null
                            : () {
                                for (int i = 0;
                                    i < value.spesifikasi.length;
                                    i++) {
                                  value.updateValue(
                                    i,
                                    value.controllers[i].text,
                                  );
                                }
                                value.changeId(id.text);
                                MaintenanceData data = MaintenanceData(
                                    id: id.text,
                                    spesifikasi: value.spesifikasi,
                                    url: maintenanceBefore);
                                value.saveChanges(data);
                                value.reset();
                                Navigator.pop(context);
                              },
                        child: const Text(
                          'Simpan',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }
}
