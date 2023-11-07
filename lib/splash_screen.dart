// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'selection_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const SelectionPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SvgPicture.asset(
            'assets/splash.svg',
            fit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 280, top: 40),
          child: Image.asset("assets/ut_logo.png", scale: 1.6),
        ),
        const Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Text("JULING",
                  style: TextStyle(
                      fontSize: 60,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold)),
              Text("Investigasi")
            ],
          ),
        )
      ],
    ));
  }
}
