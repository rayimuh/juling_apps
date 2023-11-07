// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:juling_apps/provider/add_data.dart';
import 'package:juling_apps/provider/count_data.dart';
import '../../variable.dart';
import 'package:juling_apps/model/model.dart';

class AddReport extends StatefulWidget {
  const AddReport({super.key});

  @override
  _AddReportState createState() => _AddReportState();
}

class _AddReportState extends State<AddReport> {
  @override
  void initState() {
    number = "INS-${DateTime.now().year}-${totalData + 1}";
    dateController.text =
        "${DateTime.now().day} ${formatMonth.format(dateNow)} ${DateTime.now().year}";
    super.initState();
  }

  void clearText() {
    dateController.clear();
    number = '';
    foundController.clear();
    dueDateController.clear();
    selectedProgress = null;
    selectedStatus = null;
    SPKController.clear();
    locationController.clear();
    selectedInfo = null;
    imageBefore = "";
    imageAfter = "";
    selectedCategory = null;
    selectedSubcategory = null;
    selectedPic = null;
  }

  Future<String> uploadImageBefore(String imageName) async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(          
            title: const Text(
              "Tambah Laporan",
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
                clearText();
              },
            )),
        backgroundColor: Colors.white,
        body: Consumer<AddDataProvider>(
          builder: (context, value, child) {
            return Stack(
            children: [
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
                          controller: dateController,
                          decoration: InputDecoration(
                            labelStyle: const TextStyle(
                              color: Colors.black,
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
                          controller: foundController,
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
                          controller: locationController,
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
                          controller: dueDateController,
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
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              setState(() {
                                dueDateController.text = formattedDate;
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
                        value: selectedProgress,
                        items: progressList
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedProgress = val as String;
                          });
                        },
                        decoration: const InputDecoration(
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
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
                        value: selectedStatus,
                        items: statusList
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedStatus = val as String;
                          });
                        },
                        decoration: const InputDecoration(
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
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
                            value: selectedCategory,
                            items: category.keys.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCategory = newValue;
                                selectedSubcategory =
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
                          if (selectedCategory != null)
                            DropdownButtonFormField<String>(
                              value: selectedSubcategory,
                              items: category[selectedCategory]!
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedSubcategory = newValue;
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
                          top: 20, left: 25, right: 25, bottom: 25),
                      child: DropdownButtonFormField(
                        focusColor: Colors.grey,
                        value: selectedPic,
                        items: pic
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedPic = val as String;
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
                        value: selectedInfo,
                        items: informationList
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedInfo = val as String;
                          });
                        },
                        decoration: const InputDecoration(
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
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
                          controller: SPKController,
                          decoration: InputDecoration(
                            labelStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: 'Nomor SPK',
                          ),
                        )),
                    const SizedBox(
                      height: 10,
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
                            child: imageBefore != ""
                                ? Image.network(imageBefore)
                                : const Center(
                                    child: Text(
                                        'Klik untuk tambah foto sebelum perbaikan'),
                                  ),
                          ),
                        ),
                      ),
                      onTap: () async {
                        final String imageDestination =
                            await uploadImageBefore(number);

                        setState(() {
                          imageBefore = imageDestination;
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
                        'Simpan',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      onPressed: () async {
                        final InspectionData data = InspectionData(
                            date: dateController.text,
                            number: number,
                            found: foundController.text,
                            dueDate: dueDateController.text,
                            progress: selectedProgress ?? "Open",
                            status: selectedStatus ?? "Need Update",
                            SPK: SPKController.text,
                            location: locationController.text,
                            information: selectedInfo ?? "SPK",
                            linkBefore: imageBefore,
                            linkAfter: imageAfter,
                            timestamp: Timestamp.fromDate(DateTime(
                                dateNow.year,
                                dateNow.month,
                                dateNow.day,
                                dateNow.hour,
                                dateNow.minute,
                                dateNow.second)),
                            year: DateTime.now().year,
                            pic: selectedPic ?? "Others",
                            category: selectedCategory ?? "Others",
                            subCategory: selectedSubcategory ?? "Others");
                        value.addData(data);
                        context.read<CountDataProvider>().countT();
                        clearText();
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(height: 15)
                  ],
                ),
              ),
            ]);
          },
        ));
  }
}
