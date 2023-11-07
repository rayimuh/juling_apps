import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:juling_apps/asset/ga_page/add_report_ga.dart';
import 'package:juling_apps/asset/ga_page/report_list_ga.dart';

class HomePageGA extends StatefulWidget {
  const HomePageGA({super.key});

  @override
  State<HomePageGA> createState() => _HomePageGAState();
}

class _HomePageGAState extends State<HomePageGA> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              "Inspeksi",
              style: TextStyle(color: Colors.black),
            ),
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
        backgroundColor: const Color(0xFFFFFDD3),
        body: Stack(children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SvgPicture.asset("assets/home.svg", fit: BoxFit.fill),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    key: const Key("key_AddReport"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const AddReport())));
                    },
                    child: ClipRRect(
                      child: Container(
                        height: 200,
                        width: 320,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          border: Border.all(color: Colors.black),
                          image: const DecorationImage(
                              image: AssetImage("assets/add_report.jpg"),
                              fit: BoxFit.fill),
                        ),
                        child: const Column(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(right: 130, top: 15),
                                child: Text(
                                  "Tambah Laporan",
                                  style: TextStyle(fontSize: 20),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  InkWell(
                    key: const Key("key_ListReport"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const ReportList())));
                    },
                    child: ClipRRect(
                      child: Container(
                        height: 200,
                        width: 320,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          border: Border.all(color: Colors.black),
                          image: const DecorationImage(
                              image: AssetImage("assets/list_report.jpg"),
                              fit: BoxFit.fill),
                        ),
                        child: const Column(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(left: 150, top: 15),
                                child: Text(
                                  "Daftar Laporan",
                                  style: TextStyle(fontSize: 20),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]));
  }
}
