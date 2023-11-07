// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:juling_apps/maintenance/maintenance_auth_page/home_page_maintenance.dart';
import 'package:juling_apps/maintenance/maintenance_guest_page/home_page_maintenance_guest.dart';
import 'package:juling_apps/provider/auth_user.dart';
import 'package:juling_apps/variable.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  void clear(){
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
        body: Consumer<AuthProvider>(
          builder: (context, value, child) {
            return Stack(key:const Key("key_auth"),children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: SvgPicture.asset("assets/auth.svg", fit: BoxFit.fill),
              ),
              SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 90),
                      const Text("Login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 40)),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                          margin: const EdgeInsets.all(20),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelStyle: const TextStyle(
                                color: Colors.black,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelText: 'Email',
                            ),
                          )),
                      Container(
                          margin: const EdgeInsets.all(20),
                          child: TextField(
                            obscureText: true,
                            controller: passwordController,
                            decoration: InputDecoration(
                              labelStyle: const TextStyle(
                                color: Colors.black,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelText: 'Password',
                            ),
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                side:
                                    const BorderSide(color: Color(0xFF394B78)),
                                backgroundColor: const Color(0xFF394B78),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80))),
                            onPressed: value.isLoading
                                ? null
                                : () async{
                                    await value.signInWithEmailAndPassword(
                                        emailController.text,
                                        passwordController.text);                                    
                                    value.user!=null
                                        ? Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomePageMaintenance()))
                                        : null;
                                    clear();
                                  },
                            child: const Text(
                              'Masuk',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 30),
                          ElevatedButton(
                            key: const Key("key_guest"),
                            style: ElevatedButton.styleFrom(
                                side: const BorderSide(color: Colors.black),
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80))),
                            child: const Text(
                              'Guest',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomePageMaintenanceGuest()));
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ]);
          },
        ));
  }
}
