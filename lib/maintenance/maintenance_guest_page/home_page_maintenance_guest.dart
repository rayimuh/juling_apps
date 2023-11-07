import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:juling_apps/maintenance/maintenance_general_page/scan_page.dart';

class HomePageMaintenanceGuest extends StatefulWidget {
  const HomePageMaintenanceGuest({super.key});

  @override
  State<HomePageMaintenanceGuest> createState() =>
      _HomePageMaintenanceGuestState();
}

class _HomePageMaintenanceGuestState extends State<HomePageMaintenanceGuest> {
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
        backgroundColor: const Color(0xFFFFFDD3),
        body: Stack(key: const Key("key_stackGuest"),children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SvgPicture.asset("assets/home.svg", fit: BoxFit.fill),
          ),
          Center(
            child: InkWell(
              key: const Key("key_qrPage"),
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
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
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
          ),
        ]));
  }
}
