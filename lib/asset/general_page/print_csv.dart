import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:juling_apps/provider/list_data.dart';

List<List<String?>> dataList = [];

class PrintCSV extends StatefulWidget {
  const PrintCSV({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _PrintCSVState createState() => _PrintCSVState();
}

class _PrintCSVState extends State<PrintCSV> {
  @override
  void initState() {
    super.initState();
    dataList = [
      <String>[
        "Tanggal",
        "Kode Inspeksi",
        "Temuan",
        "Lokasi",
        "Due Date",
        "Progress",
        "Status",
        "PIC",
        "Kategori",
        "Sub-Kategori",
        "Keterangan",
        "No SPK",  
        "Link Foto Sebelum",
        "Link Foto Sesudah",
        "Year"        
      ]
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDD3),
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 0.0,
        title: const Text(
          "Data yang Dieksport",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Consumer<ListDataProvider>(
        builder: (context, value, _) => Stack(
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: SvgPicture.asset(
                "assets/add_report.svg",
                fit: BoxFit.fill,
              ),
            ),
            StreamBuilder(
              stream: value.getDataList(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            var doc = snapshot.data![index];
                            dataList.add([
                              doc.date,
                              doc.number,
                              doc.found,
                              doc.dueDate,
                              doc.progress,
                              doc.status,
                              doc.pic,
                              doc.category,
                              doc.subCategory,
                              doc.SPK,
                              doc.location,
                              doc.information,
                              doc.linkBefore,
                              doc.linkAfter,
                              doc.year.toString()                              
                            ]);
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Card(
                                color: const Color(0xFFF6F073),
                                elevation: 4,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: ListTile(
                                  title: Text("Nomor : ${doc.number}"),
                                  subtitle: Text(
                                      'Tanggal : ${doc.date}\nTemuan : ${doc.found}\nLocation : ${doc.location}\nDue Date : ${doc.dueDate}\nProgress : ${doc.progress}\nStatus : ${doc.status}\nPIC : ${doc.pic}\nKategori : ${doc.category}\nSub-Kategori : ${doc.subCategory}\nKeterangan : ${doc.information}\nNo. SPK : ${doc.SPK}'),
                                ),
                              ),
                            );
                          },
                          itemCount: snapshot.data!.length,
                        ),
                      )
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.file_download,
          color: Color(0xFF394B78),
        ),
        onPressed: () async {
          await fetchAndGenerateCSV();
          Fluttertoast.showToast(msg: "Data sudah di eksport");
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        },
      ),
    );
  }
}
  Future<void> fetchAndGenerateCSV() async {
    List<List<String?>> dataList = [
      <String>[
        "Tanggal",
        "Kode Inspeksi",
        "Temuan",
        "Lokasi",
        "Due Date",
        "Progress",
        "Status",
        "PIC",
        "Kategori",
        "Sub-Kategori",
        "Keterangan",
        "No SPK",  
        "Link Foto Sebelum",
        "Link Foto Sesudah",
        "Tahun"
      ]
    ];
    final snapshot =
        await FirebaseFirestore.instance.collection('data').get();
    for (var document in snapshot.docs) {
      Map<String, dynamic> data = document.data();
      dataList.add([
        data['date'] ?? "",
        data['number'] ?? "",
        data['found'] ?? "",
        data['location'] ?? "",
        data['dueDate'] ?? "",
        data['progress'] ?? "",
        data['status'] ?? "",
        data['pic'] ?? "",
        data['category'] ?? "",
        data['sub-category'] ?? "",
        data['information'] ?? "",
        data['no SPK'] ?? "", 
        data['link before'] ?? "",
        data['link after'] ?? "",
        data['year'].toString() 
      ]);
    }
    String csvData = const ListToCsvConverter().convert(dataList);
    DateTime now = DateTime.now();
    String formattedDate = DateFormat("MM-dd-yyyy").format(now);
    Directory save = Directory('storage/emulated/0/Download');
    final File file =
        await (File("${save.path}/Data-$formattedDate.csv").create());
    await file.writeAsString(csvData);
    Fluttertoast.showToast(msg: "Data is exported");
  }