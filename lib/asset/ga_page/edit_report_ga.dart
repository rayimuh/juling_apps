// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:juling_apps/model/model.dart';
import 'package:juling_apps/provider/edit_data.dart';
import '../../variable.dart';

class EditReport extends StatefulWidget {
  final String date;
  final String number;
  final String found;
  final String? dueDate;
  final String progress;
  final String status;
  final String? SPK;
  final String location;
  final String information;
  final String? linkBefore;
  final String? linkAfter;
  final Timestamp timestamp;
  final int year;
  final String pic;
  final String category;
  final String subCategory;
  const EditReport(
      {Key? key,
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
      required this.pic,
      required this.category,
      required this.subCategory})
      : super(key: key);
  @override
  _EditReportState createState() => _EditReportState();
}

class _EditReportState extends State<EditReport> {
  @override
  void initState() {
    editNumber = widget.number;
    editDateController.text = widget.date;
    editFoundController.text = widget.found;
    editDueDateController.text = widget.dueDate ?? "-";
    editSelectedProgress = widget.progress;
    editSelectedStatus = widget.status;
    editSPKController.text = widget.SPK ?? "-";
    editLocationController.text = widget.location;
    editSelectedInfo = widget.information;
    editImageBefore = widget.linkBefore;
    editImageAfter = widget.linkAfter;
    editPic = widget.pic;
    editCategory = widget.category;
    editSubCategory = widget.subCategory;
    super.initState();
  }

  Future<String> uploadNewImageBefore(String imageName) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await showDialog<XFile>(
      context: context,
      builder: (context) => GestureDetector(
        onTap:
            () {}, // To prevent the dialog from being dismissed when tapped outside
        child: AlertDialog(
          title: const Text("Select image source"),
          actions: [
            TextButton(
              onPressed: () async {
                final image = await picker.pickImage(
                  source: ImageSource.camera,
                  imageQuality: 5,
                );
                Navigator.pop(context, image);
              },
              child: const Text("Camera"),
            ),
            TextButton(
              onPressed: () async {
                final image = await picker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 5,
                );
                Navigator.pop(context, image);
              },
              child: const Text("Gallery"),
            ),
          ],
        ),
      ),
    );

    if (image != null) {
      Reference ref =
          FirebaseStorage.instance.ref().child("$imageName before.jpg");
      UploadTask uploadTask = ref.putFile(File(image.path));

      // Show the circular progress indicator while the image is being uploaded
      showDialog(
        context: context,
        barrierDismissible: false, // Prevents the dialog from being dismissed
        builder: (context) => const Dialog(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20.0),
                Text("Uploading Image..."),
              ],
            ),
          ),
        ),
      );

      await uploadTask.whenComplete(() =>
          Navigator.pop(context)); // Dismiss the dialog when upload is complete

      return await ref.getDownloadURL();
    }

    return "";
  }

  Future<String> uploadNewImageAfter(String imageName) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await showDialog<XFile>(
      context: context,
      builder: (context) => GestureDetector(
        onTap:
            () {}, // To prevent the dialog from being dismissed when tapped outside
        child: AlertDialog(
          title: const Text("Select image source"),
          actions: [
            TextButton(
              onPressed: () async {
                final image = await picker.pickImage(
                  source: ImageSource.camera,
                  imageQuality: 5,
                );
                Navigator.pop(context, image);
              },
              child: const Text("Camera"),
            ),
            TextButton(
              onPressed: () async {
                final image = await picker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 5,
                );
                Navigator.pop(context, image);
              },
              child: const Text("Gallery"),
            ),
          ],
        ),
      ),
    );

    if (image != null) {
      Reference ref =
          FirebaseStorage.instance.ref().child("$imageName after.jpg");
      UploadTask uploadTask = ref.putFile(File(image.path));

      // Show the circular progress indicator while the image is being uploaded
      showDialog(
        context: context,
        barrierDismissible: false, // Prevents the dialog from being dismissed
        builder: (context) => const Dialog(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20.0),
                Text("Uploading Image..."),
              ],
            ),
          ),
        ),
      );

      await uploadTask.whenComplete(() =>
          Navigator.pop(context)); // Dismiss the dialog when upload is complete

      return await ref.getDownloadURL();
    }

    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              "Edit Report",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.transparent,
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
        backgroundColor: Colors.white,
        body: Consumer<EditDataProvider>(
            builder: (context, value, _) => Stack(children: [
                  SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: SvgPicture.asset(
                        "assets/add_report.svg",
                        fit: BoxFit.fill,
                      )),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                            margin: const EdgeInsets.all(20),
                            child: TextField(
                              controller: editDateController,
                              decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                  color: Colors.black, //<-- SEE HERE
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: 'Tanggal',
                              ),
                            )),
                        const SizedBox(height: 10),
                        Container(
                            margin: const EdgeInsets.all(20),
                            child: TextField(
                              controller: editFoundController,
                              decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: 'Temuan',
                              ),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                            margin: const EdgeInsets.all(20),
                            child: TextField(
                              controller: editLocationController,
                              decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: 'Lokasi',
                              ),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                            margin: const EdgeInsets.all(20),
                            child: TextField(
                              controller: editDueDateController,
                              decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: 'Due Date',
                              ),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    builder: (context, child) {
                                      return Theme(
                                        data: ThemeData(
                                          primarySwatch: Colors.yellow,
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              foregroundColor: Colors.black,
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(3000));
                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  setState(() {
                                    editDueDateController.text = formattedDate;
                                  });
                                }
                              },
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(25),
                          child: DropdownButtonFormField(
                            focusColor: Colors.grey,
                            value: editSelectedProgress,
                            items: progressList
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ))
                                .toList(),
                            onChanged: (val) {
                              setState(() {
                                editSelectedProgress = val as String;
                              });
                            },
                            decoration: const InputDecoration(
                                hintText: "Progress",
                                border: UnderlineInputBorder()),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(25),
                          child: DropdownButtonFormField(
                            focusColor: Colors.grey,
                            value: editSelectedStatus,
                            items: statusList
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ))
                                .toList(),
                            onChanged: (val) {
                              setState(() {
                                editSelectedStatus = val as String;
                              });
                            },
                            decoration: const InputDecoration(
                                hintText: "Status",
                                border: UnderlineInputBorder()),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            children: [
                              DropdownButtonFormField<String>(
                                value: editCategory,
                                items: category.keys.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    editCategory = newValue;
                                    editSubCategory =
                                        null; // Reset the sub-item when category changes
                                  });
                                },
                                decoration: const InputDecoration(
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  hintText: "Kategori",
                                  border: UnderlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 45),
                              if (editCategory != null)
                                DropdownButtonFormField<String>(
                                  value: editSubCategory,
                                  items: category[editCategory]!
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      editSubCategory = newValue;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    hintText: "Sub Kategori",
                                    border: UnderlineInputBorder(),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25, right: 25, top: 25, bottom: 25),
                          child: DropdownButtonFormField(
                            focusColor: Colors.grey,
                            value: editPic,
                            items: pic
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ))
                                .toList(),
                            onChanged: (val) {
                              setState(() {
                                editPic = val as String;
                              });
                            },
                            decoration: const InputDecoration(
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                hintText: "PIC",
                                border: UnderlineInputBorder()),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(25),
                          child: DropdownButtonFormField(
                            focusColor: Colors.grey,
                            value: editSelectedInfo,
                            items: informationList
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ))
                                .toList(),
                            onChanged: (val) {
                              setState(() {
                                editSelectedInfo = val as String;
                              });
                            },
                            decoration: const InputDecoration(
                                hintText: "Keterangan",
                                border: UnderlineInputBorder()),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                            margin: const EdgeInsets.all(20),
                            child: TextField(
                              controller: editSPKController,
                              decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: 'SPK',
                              ),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              height: 200,
                              width: double.infinity,
                              margin: const EdgeInsets.all(20),
                              child: Card(
                                child: Center(
                                  child: editImageBefore != ""
                                      ? Image.network(editImageBefore!)
                                      : const Center(
                                          child: Text(
                                              'Klik untuk tambah foto sebelum perbaikan'),
                                        ),
                                ),
                              )),
                          onTap: () async {
                            final String imageDestination =
                                await uploadNewImageBefore(editNumber);

                            setState(() {
                              editImageBefore = imageDestination;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          child: Container(
                              margin: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              height: 200,
                              width: double.infinity,
                              child: Card(
                                child: Center(
                                  child: editImageAfter != ""
                                      ? Image.network(editImageAfter!)
                                      : const Center(
                                          child: Text(
                                              'Klik untuk tambah foto sesudah perbaikan'),
                                        ),
                                ),
                              )),
                          onTap: () async {
                            final String imageDestination =
                                await uploadNewImageAfter(editNumber);

                            setState(() {
                              editImageAfter = imageDestination;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF394B78),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80))),
                          child: const Text(
                            'Simpan Perubahan',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          onPressed: () {
                            value.updateData(
                                widget.number,
                                InspectionData(
                                    date: editDateController.text,
                                    number: widget.number,
                                    found: editFoundController.text,
                                    dueDate: editDueDateController.text,
                                    progress: editSelectedProgress!,
                                    status: editSelectedStatus!,
                                    SPK: editSPKController.text,
                                    location: editLocationController.text,
                                    information: editSelectedInfo!,
                                    linkBefore: editImageBefore,
                                    linkAfter: editImageAfter,
                                    timestamp: widget.timestamp,
                                    year: widget.year,
                                    pic: editPic!,
                                    category: editCategory!,
                                    subCategory: editSubCategory!));
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(height: 15)
                      ],
                    ),
                  ),
                ])));
  }
}
