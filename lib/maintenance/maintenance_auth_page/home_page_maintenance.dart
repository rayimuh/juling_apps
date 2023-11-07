import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:juling_apps/maintenance/maintenance_auth_page/add_page_maintenance.dart';
import 'package:juling_apps/maintenance/maintenance_general_page/scan_page.dart';
import 'package:juling_apps/provider/auth_user.dart';

class HomePageMaintenance extends StatefulWidget {
  const HomePageMaintenance({super.key});

  @override
  State<HomePageMaintenance> createState() => _HomePageMaintenanceState();
}

class _HomePageMaintenanceState extends State<HomePageMaintenance> {
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
            child: const Icon(Icons.logout, color: Colors.white,),
            onPressed: () {
              context.read<AuthProvider>().signOut();
              Navigator.pop(context);
            }),
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
                    key: const Key("key_gaQRPage"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const ScanPage())));
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
                              image: AssetImage("assets/scan_qr.jpg"),
                              fit: BoxFit.fill),
                        ),
                        child: const Column(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(right: 160, top: 15),
                                child: Text(
                                  "Pindai QR",
                                  style: TextStyle(fontSize: 25),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  InkWell(
                    key: const Key("key_addMaintenancePage"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  const AddDataMaintenance())));
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
                                padding: EdgeInsets.only(left: 160, top: 15),
                                child: Text(
                                  "Tambah Data",
                                  style: TextStyle(fontSize: 25),
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
