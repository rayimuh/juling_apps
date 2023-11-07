import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:d_chart/d_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:juling_apps/variable.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ChartPage extends StatefulWidget {
  final Timestamp dateStart;
  final Timestamp dateEnd;
  const ChartPage({super.key, required this.dateStart, required this.dateEnd});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  PageController page = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            setState(() {});
          },
          child: const Icon(Icons.refresh, color: Color(0xFF394B78)),
        ),
        appBar: AppBar(
            title: const Text(
              "Bagan",
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
        body: Stack(
          children: [
            PageView(
              controller: page,
              children: [
                Stack(children: [
                  SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: SvgPicture.asset("assets/chart_1.svg",
                        fit: BoxFit.fill),
                  ),
                  StreamBuilder(
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.docs.isEmpty) {
                            return const Center(
                              child: Text(
                                'Tidak ada data',
                                style: TextStyle(fontSize: 15),
                              ),
                            );
                          } else {
                            return Center(
                              child: AspectRatio(
                                aspectRatio: 3,
                                child: DChartPie(
                                    labelLineThickness: 4,
                                    labelLinelength: 25,
                                    labelPosition: PieLabelPosition.outside,
                                    animationDuration: const Duration(seconds: 1),
                                    labelFontSize: 12,
                                    showLabelLine: true,
                                    labelColor: Colors.black,
                                    data: [
                                      {
                                        'domain': 'Completed',
                                        'measure': completed / grandTotal * 100
                                      },
                                      {
                                        'domain': 'Open',
                                        'measure': open / grandTotal * 100
                                      },
                                      {
                                        'domain': 'Mat.Prep',
                                        'measure':
                                            materialPrep / grandTotal * 100
                                      },
                                      {
                                        'domain': 'Prog.Cons',
                                        'measure':
                                            progressCons / grandTotal * 100
                                      },
                                    ],
                                    fillColor: (pieData, index) {
                                      switch (pieData["domain"]) {
                                        case "Open":
                                          return const Color(0xFF2C486E);
                                        case "Mat.Prep":
                                          return const Color(0XFFABC0DD);
                                        case "Completed":
                                          return const Color(0XFF527BB4);
                                        default:
                                          return const Color(0XFF323B46);
                                      }
                                    },
                                    pieLabel: (pieData, index) {
                                      return pieData["domain"] +
                                          ":\n" +
                                          pieData["measure"].toString() +
                                          "%";
                                    }),
                              ),
                            );
                          }
                        } else if (snapshot.hasError) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                      stream: FirebaseFirestore.instance
                          .collection("data")
                          .snapshots()),
                ]),
                Stack(children: [
                  SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: SvgPicture.asset("assets/chart_2.svg",
                        fit: BoxFit.fill),
                  ),
                  StreamBuilder(
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.docs.isEmpty) {
                            return const Center(
                              child: Text(
                                'Tidak ada data',
                                style: TextStyle(fontSize: 15),
                              ),
                            );
                          } else {
                            return Center(
                              child: AspectRatio(
                                aspectRatio: 3,
                                child: DChartPie(
                                    labelLineThickness: 4,
                                    labelLinelength: 25,
                                    labelPosition: PieLabelPosition.outside,
                                    animationDuration: const Duration(seconds: 1),
                                    labelFontSize: 12,
                                    showLabelLine: true,
                                    labelColor: Colors.black,
                                    data: [
                                      {
                                        'domain': 'Need Update',
                                        'measure': needUpdate / grandTotal * 100
                                      },
                                      {
                                        'domain': 'No Need Updt',
                                        'measure':
                                            noNeedUpdate / grandTotal * 100
                                      },
                                    ],
                                    fillColor: (pieData, index) {
                                      switch (pieData["domain"]) {
                                        case "Need Update":
                                          return const Color(0xFF2C486E);
                                        case "No Need Update":
                                          return const Color(0XFF527BB4);
                                        default:
                                          return const Color(0XFF323B46);
                                      }
                                    },
                                    pieLabel: (pieData, index) {
                                      return pieData["domain"] +
                                          ":\n" +
                                          pieData["measure"].toString() +
                                          "%";
                                    }),
                              ),
                            );
                          }
                        } else if (snapshot.hasError) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                      stream: FirebaseFirestore.instance
                          .collection("data")
                          .snapshots()),
                ]),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                      child: SmoothPageIndicator(
                    controller: page,
                    count: 2,
                    effect: const WormEffect(),
                    onDotClicked: (index) {
                      page.animateToPage(index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.bounceOut);
                    },
                  )),
                )
              ],
            )
          ],
        ));
  }
}
