// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:juling_apps/asset/ga_page/edit_report_ga.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:juling_apps/asset/general_page/chart_page.dart';
import 'package:juling_apps/provider/count_data.dart';
import 'package:juling_apps/provider/list_data.dart';
import '../general_page/print_csv.dart';
import 'package:intl/intl.dart';
import '../../variable.dart';

class ReportList extends StatefulWidget {
  const ReportList({Key? key}) : super(key: key);

  @override
  State<ReportList> createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  void clearText() {
    filterDateBegin.clear();
    filterDateEnd.clear();
    filterStart = null;
    filterEnd = null;
    filterProgress = null;
    filterStatus = null;
    filterCategory = null;
    filterPIC = null;
    filterSPK.clear();
    filterNumber.clear();
    completedOrNot=null;
    chartDateBegin.clear();
    chartDateEnd.clear();
    chartStart = null;
    chartEnd = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xFF394B78),
            onPressed: () {
              (showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: SizedBox(
                        height: 190,
                        width: 600,
                        child: Wrap(
                          children: [
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: TextField(
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      builder: (context, child) {
                                        return Theme(
                                          data: ThemeData(
                                            primarySwatch: Colors.yellow,
                                            textButtonTheme:
                                                TextButtonThemeData(
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
                                    pickedDateToChartStart = DateTime(
                                        pickedDate.year,
                                        pickedDate.month,
                                        pickedDate.day,
                                        0,
                                        0,
                                        0);
                                    chartStart = Timestamp.fromDate(
                                        pickedDateToChartStart);
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd')
                                            .format(pickedDate);
                                    setState(() {
                                      chartDateBegin.text = formattedDate;
                                    });
                                  }
                                },
                                controller: chartDateBegin,
                                decoration: const InputDecoration(
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    labelText: 'Dari tanggal',
                                    suffixIcon: Icon(Icons.search)),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: TextField(
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      builder: (context, child) {
                                        return Theme(
                                          data: ThemeData(
                                            primarySwatch: Colors.yellow,
                                            textButtonTheme:
                                                TextButtonThemeData(
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
                                    pickedDateToChartEnd = DateTime(
                                        pickedDate.year,
                                        pickedDate.month,
                                        pickedDate.day,
                                        23,
                                        59,
                                        59);
                                    chartEnd = Timestamp.fromDate(
                                        pickedDateToChartEnd);
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd')
                                            .format(pickedDate);
                                    setState(() {
                                      chartDateEnd.text = formattedDate;
                                    });
                                  }
                                },
                                controller: chartDateEnd,
                                decoration: const InputDecoration(
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    labelText: 'Sampai tanggal',
                                    suffixIcon: Icon(Icons.search)),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Consumer<CountDataProvider>(
                                  builder: (context, value, child) =>
                                      ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF394B78),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 5),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(80))),
                                    child: const Text(
                                      'Terapkan',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    onPressed: () {
                                      if (chartDateBegin.text.isEmpty ||
                                          chartDateEnd.text.isEmpty ||
                                          pickedDateToChartStart == null ||
                                          pickedDateToChartEnd == null ||
                                          chartStart == null ||
                                          chartEnd == null) {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            title: const Text("Peringatan"),
                                            content: const Text(
                                                "Anda belum pilih tanggal"),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(ctx).pop();
                                                  Navigator.of(ctx).pop();
                                                },
                                                child: const Text("Ok"),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        value.countGT(chartStart, chartEnd);
                                        value.countC(chartStart, chartEnd);
                                        value.countMP(chartStart, chartEnd);
                                        value.countO(chartStart, chartEnd);
                                        value.countPC(chartStart, chartEnd);
                                        value.countNU(chartStart, chartEnd);
                                        value.countNNU(chartStart, chartEnd);
                                        Timer(const Duration(seconds: 1), () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ChartPage(
                                                    dateStart: chartStart,
                                                    dateEnd: chartStart),
                                              ));
                                        });
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(width: 20),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF394B78),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 5),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(80))),
                                  child: const Text(
                                    'Kembali',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                  onPressed: () {
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }));
            },
            child: const Icon(
              Icons.pie_chart,
              color: Colors.white,
            )),
        backgroundColor: const Color(0xFFFFFDD3),
        appBar: AppBar(
            backgroundColor: Colors.white,
            bottomOpacity: 0.0,
            elevation: 0.0,
            title: const Text("Daftar Laporan",
                style: TextStyle(color: Colors.black)),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      isReversed = !isReversed;
                    });
                  },
                  icon: const Icon(
                    Icons.filter_list,
                    color: Colors.black,
                  )),
              IconButton(
                key: const Key("key_print"),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const PrintCSV();
                      },
                    ));
                  },
                  icon: const Icon(
                    Icons.download,
                    color: Colors.black,
                  )),
              IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25.0),
                          ),
                        ),
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return Wrap(
                            children: [
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: TextField(
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        builder: (context, child) {
                                          return Theme(
                                            data: ThemeData(
                                              primarySwatch: Colors.yellow,
                                              textButtonTheme:
                                                  TextButtonThemeData(
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
                                      pickedDateToFilterStart = DateTime(
                                          pickedDate.year,
                                          pickedDate.month,
                                          pickedDate.day,
                                          0,
                                          0,
                                          0);
                                      filterStart = Timestamp.fromDate(
                                          pickedDateToFilterStart);
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
                                      setState(() {
                                        filterDateBegin.text = formattedDate;
                                      });
                                    }
                                  },
                                  controller: filterDateBegin,
                                  decoration: const InputDecoration(
                                      labelStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                      labelText:
                                          'Filter berdasarkan range tanggal awal',
                                      suffixIcon: Icon(Icons.search)),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: TextField(
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        builder: (context, child) {
                                          return Theme(
                                            data: ThemeData(
                                              primarySwatch: Colors.yellow,
                                              textButtonTheme:
                                                  TextButtonThemeData(
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
                                      pickedDateToFilterEnd = DateTime(
                                          pickedDate.year,
                                          pickedDate.month,
                                          pickedDate.day,
                                          23,
                                          59,
                                          59);
                                      filterEnd = Timestamp.fromDate(
                                          pickedDateToFilterEnd);
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
                                      setState(() {
                                        filterDateEnd.text = formattedDate;
                                      });
                                    }
                                  },
                                  controller: filterDateEnd,
                                  decoration: const InputDecoration(
                                      labelStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                      labelText:
                                          'Filter berdasarkan range tanggal akhir',
                                      suffixIcon: Icon(Icons.search)),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: DropdownButtonFormField(
                                  value: filterProgress,
                                  items:  progressList
                                      .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e),
                                          ))
                                      .toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      filterProgress = val as String;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                      hintStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                      hintText: "Filter berdasarkan progress",
                                      border: UnderlineInputBorder()),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: DropdownButtonFormField(
                                  value: completedOrNot,
                                  items:  filterCompleteOrNot
                                      .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e),
                                          ))
                                      .toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      completedOrNot = val as String;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                      hintStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                      hintText: "Filter berdasarkan complete/non-complete",
                                      border: UnderlineInputBorder()),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: DropdownButtonFormField(
                                  value: filterStatus,
                                  items: statusList
                                      .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e),
                                          ))
                                      .toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      filterStatus = val as String;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                      hintStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                      hintText: "Filter berdasarkan status",
                                      border: UnderlineInputBorder()),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: DropdownButtonFormField(
                                  value: filterCategory,
                                  items:  category.keys
                                      .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e),
                                          ))
                                      .toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      filterCategory = val as String;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                      hintStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                      hintText: "Filter berdasarkan kategori",
                                      border: UnderlineInputBorder()),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: DropdownButtonFormField(
                                  value: filterPIC,
                                  items:  pic
                                      .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e),
                                          ))
                                      .toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      filterPIC = val as String;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                      hintStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                      hintText: "Filter berdasarkan pic",
                                      border: UnderlineInputBorder()),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: TextField(
                                  controller: filterSPK,
                                  decoration: const InputDecoration(
                                      labelStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                      labelText: 'Filter berdasarkan SPK',
                                      suffixIcon: Icon(Icons.search)),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: TextField(
                                    controller: filterNumber,
                                    decoration: const InputDecoration(
                                        labelStyle: TextStyle(
                                          color: Colors.black,
                                        ),
                                        labelText: 'Filter berdasarkan nomor inspeksi',
                                        suffixIcon: Icon(Icons.search)),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF394B78),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 5),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(80))),
                                    child: const Text(
                                      'Simpan',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    onPressed: () {
                                      setState(() {});
                                      Navigator.pop(context);
                                    },
                                  ),
                                  const SizedBox(width: 20),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF394B78),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 5),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(80))),
                                    child: const Text(
                                      'Clear Filter',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    onPressed: () {
                                      setState(() {});
                                      Navigator.pop(context);
                                      clearText();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          );
                        });
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ))
            ],
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        body: Consumer<ListDataProvider>(
          builder: (context, value, _) => Stack(children: [
            SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: SvgPicture.asset(
                  "assets/add_report.svg",
                  fit: BoxFit.fill,
                )),
            StreamBuilder(
                stream: (filterDateBegin.text == "" &&
                            filterDateBegin.text.isEmpty) &&
                        (filterDateEnd.text == "" ||
                            filterDateEnd.text.isEmpty) &&
                        (filterStart == null) &&
                        (filterEnd == null) &&
                        (filterProgress == null) &&
                        (filterStatus == null) &&
                        (filterCategory == null) &&
                        (filterPIC == null ) &&
                        (filterSPK.text == "" || filterSPK.text.isEmpty)&&
                        (filterNumber.text==""||filterNumber.text.isEmpty)&&
                        (completedOrNot == null)
                    ? value.getDataList()
                    : value.filterData(filterStart, filterEnd, filterProgress,
                        filterStatus, filterSPK.text,filterNumber.text,completedOrNot,filterCategory,filterPIC),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return const Center(child: Text("Tidak ada data"));
                    } else {
                      final data = snapshot.data!;
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                                reverse: isReversed,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  final dataList = data[index];
                                  final key = Key("key_list_$index");
                                  return Padding( 
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Card(                                                                            
                                      color: const Color(0xFFF6F073),
                                      elevation: 4,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: ListTile(
                                        key: key,
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      EditReport(
                                                        date: dataList.date,
                                                        number:
                                                            dataList.number,
                                                        found: dataList.found,
                                                        dueDate:
                                                            dataList.dueDate,
                                                        progress:
                                                            dataList.progress,
                                                        status:
                                                            dataList.status,
                                                        SPK: dataList.SPK,
                                                        location:
                                                            dataList.location,
                                                        information: dataList
                                                            .information,
                                                        linkBefore: dataList
                                                            .linkBefore,
                                                        linkAfter: dataList
                                                            .linkAfter,
                                                        timestamp: dataList
                                                            .timestamp,
                                                        year: dataList.year,
                                                        pic: dataList.pic,
                                                        category: dataList.category,
                                                        subCategory: dataList.subCategory,
                                                      ))));
                                        },
                                        title: Text(
                                            "Nomor : ${dataList.number}"),
                                        subtitle: Text(
                                            'Tanggal : ${dataList.date}\nTemuan : ${dataList.found}\nLocation : ${dataList.location}\nDue Date : ${dataList.dueDate}\nProgress : ${dataList.progress}\nStatus : ${dataList.status}\nPIC : ${dataList.pic}\nKategori : ${dataList.category}\nSub-Kategori : ${dataList.subCategory}\nKeterangan : ${dataList.information}\nNo. SPK : ${dataList.SPK}'),
                                      ),
                                    ),
                                  );
                                })
                          ],
                        ),
                      );
                    }
                  } else if (snapshot.hasError) {                    
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ]),
        ));
  }
}
