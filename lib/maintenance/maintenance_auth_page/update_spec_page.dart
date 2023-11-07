// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:juling_apps/model/model_maintenance.dart';
import 'package:juling_apps/provider/edit_maintenance.dart';
import 'package:juling_apps/variable.dart';

class DetailSpec extends StatefulWidget {
  final String id;
  const DetailSpec({super.key, required this.id});

  @override
  State<DetailSpec> createState() => _DetailSpecState();
}

class _DetailSpecState extends State<DetailSpec> {
  Future<String> uploadNewImage(String imageName) async {
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
                Navigator.pop(context);
              },
            )),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF394B78),
          onPressed: () {
            final value =
                Provider.of<EditMaintenanceProvider>(context, listen: false);
            value.addValue();
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: Consumer<EditMaintenanceProvider>(
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
                      for (int i = 0; i < value.spesifikasi.length; i++)
                        Dismissible(
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            Provider.of<EditMaintenanceProvider>(context,
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
                      InkWell(
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
                              child: maintenanceNew != ""
                                  ? Image.network(maintenanceNew)
                                  : const Center(
                                      child: Text(
                                          'Klik untuk ganti foto perangkat'),
                                    ),
                            ),
                          ),
                        ),
                        onTap: () async {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              });

                          final String imageDestination =
                              await uploadNewImage(widget.id);

                          Navigator.of(context).pop();
                          setState(() {
                            maintenanceNew = imageDestination;
                          });
                        },
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
                              MaintenanceData data=MaintenanceData(id: widget.id, spesifikasi: value.spesifikasi, url: maintenanceNew);
                                for (int i = 0;
                                    i < value.spesifikasi.length;
                                    i++) {
                                  value.updateValue(
                                    i,
                                    value.controllers[i].text,
                                    data);
                                }
                                Fluttertoast.showToast(msg: "Data tersimpan");
                                Navigator.pop(context);
                              },
                        child: const Text(
                          'Save',
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
