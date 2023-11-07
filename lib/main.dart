import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:juling_apps/firebase_options.dart';
import 'package:juling_apps/provider/add_data.dart';
import 'package:juling_apps/provider/add_maintenance.dart';
import 'package:juling_apps/provider/auth_user.dart';
import 'package:juling_apps/provider/count_data.dart';
import 'package:juling_apps/provider/edit_data.dart';
import 'package:juling_apps/provider/edit_maintenance.dart';
import 'package:juling_apps/provider/list_data.dart';
import 'package:juling_apps/provider/list_mantenance.dart';
import 'package:juling_apps/service/firebase_service.dart';
import 'package:juling_apps/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => AddMaintenanceProvider(
                firebaseService:
                    FirebaseService(firestore:FirebaseFirestore.instance ))),
        ChangeNotifierProvider(
            create: (_) =>
                EditMaintenanceProvider(firebaseService: FirebaseService(firestore: FirebaseFirestore.instance))),
        ChangeNotifierProvider(
            create: (_) => AddDataProvider(firebaseService: FirebaseService(firestore: FirebaseFirestore.instance))),
        ChangeNotifierProvider(
            create: (_) =>
                ListDataProvider(firestore: FirebaseFirestore.instance)),
        ChangeNotifierProvider(
            create: (_) =>
                EditDataProvider(firebaseService: FirebaseService(firestore: FirebaseFirestore.instance))),
        ChangeNotifierProvider(
            create: (_) =>
                CountDataProvider(firebaseService: FirebaseService(firestore: FirebaseFirestore.instance))),
        ChangeNotifierProvider(create: (_) => MaintenanceDataProvider(firestore: FirebaseFirestore.instance)),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final beginData = context.read<CountDataProvider>();
    beginData.countT();
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.grey),
      title: "Juling",
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
