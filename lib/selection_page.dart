import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:juling_apps/asset/ga_page/home_page_ga.dart';
import 'package:juling_apps/maintenance/maintenance_general_page/auth_page.dart';
import 'package:juling_apps/maintenance/maintenance_auth_page/home_page_maintenance.dart';
import 'package:juling_apps/provider/auth_user.dart';

class SelectionPage extends StatefulWidget {
  const SelectionPage({super.key});

  @override
  State<SelectionPage> createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFFDD3),
        body: Stack(children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SvgPicture.asset("assets/splash.svg", fit: BoxFit.fill),
          ),
          Center(
            child: ListView(scrollDirection: Axis.horizontal, children: [
              const SizedBox(width: 30),
              Center(
                child: InkWell(
                  key: const Key('key_HomePageGA'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const HomePageGA())));
                  },
                  child: ClipRRect(
                    child: Container(
                        height: 430,
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          border: Border.all(color: Colors.black),
                          image: const DecorationImage(
                              image: AssetImage("assets/asset.jpg"),
                              fit: BoxFit.fill),
                        ),
                        child: const Center(
                          child: Text(
                            "Inspeksi",
                            style: TextStyle(fontSize: 40),
                          ),
                        )),
                  ),
                ),
              ),
              const SizedBox(width: 30),
              Center(
                child: InkWell(
                  key: const Key('key_AuthPage'),
                  onTap: () {
                    context.read<AuthProvider>().isSignedIn
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    const HomePageMaintenance())))
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const AuthPage())));
                  },
                  child: ClipRRect(
                    child: Container(
                        height: 430,
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          border: Border.all(color: Colors.black),
                          image: const DecorationImage(
                              image: AssetImage("assets/maintenance.jpg"),
                              fit: BoxFit.fill),
                        ),
                        child: const Center(
                          child: Text("Cek Spesifikasi",
                              style: TextStyle(fontSize: 40)),
                        )),
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              )
            ]),
          ),
        ]));
  }
}
