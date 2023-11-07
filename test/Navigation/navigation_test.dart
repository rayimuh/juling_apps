import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:juling_apps/asset/ga_page/home_page_ga.dart';
import 'package:juling_apps/asset/ga_page/report_list_ga.dart';
import 'package:juling_apps/maintenance/maintenance_auth_page/home_page_maintenance.dart';
import 'package:juling_apps/maintenance/maintenance_general_page/auth_page.dart';
import 'package:juling_apps/maintenance/maintenance_guest_page/home_page_maintenance_guest.dart';
import 'package:juling_apps/provider/add_data.dart';
import 'package:juling_apps/provider/add_maintenance.dart';
import 'package:juling_apps/provider/auth_user.dart';
import 'package:juling_apps/provider/edit_data.dart';
import 'package:juling_apps/provider/edit_maintenance.dart';
import 'package:juling_apps/provider/list_data.dart';
import 'package:juling_apps/selection_page.dart';
import 'package:juling_apps/service/firebase_service.dart';
import 'package:juling_apps/splash_screen.dart';
import '../mock_auth.dart';

class MockFirebaseService extends Mock implements FirebaseService {}
class MockAuthProvider extends AuthProvider {
  MockAuthProvider(bool isSignedIn) {
    user = isSignedIn ? MockUser() : null;
  }
}

void main() {
  group("Navigation testing", () { 
    setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });
  testWidgets('SplashScreen widget test', (WidgetTester tester) async {
    Widget columnWidget = Stack(
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
            children: [
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
    );    
    await tester.pumpWidget(
      const MaterialApp(
        home: SplashScreen(),
      ),
    );
    expect(find.text("JULING"), findsOneWidget);    
    await tester.pumpAndSettle(const Duration(seconds: 2));    
    expect(find.byWidget(columnWidget), findsNothing);
  });

  testWidgets('Navigation from SelectionPage to HomePageGA',
      (WidgetTester tester) async {    
    await tester.pumpWidget(
      const MaterialApp(
        home: SelectionPage(),
      ),
    );    
    expect(find.text('Inspeksi'), findsOneWidget);    
    final inspeksiInkWell = find.byKey(const Key('key_HomePageGA'));    
    await tester.tap(inspeksiInkWell);    
    await tester.pumpAndSettle();
    expect(find.text('Tambah Laporan'), findsOneWidget);
  });

  testWidgets('Navigation from HomePageGA to AddReport',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<AddDataProvider>(
            create: (_) =>
                AddDataProvider(firebaseService: MockFirebaseService()),
          ),          
        ],
        child: const MaterialApp(
          home: HomePageGA(),
        ),
      ),
    );    
    expect(find.text('Inspeksi'), findsOneWidget);    
    final addInspeksiInkWell = find.byKey(const Key('key_AddReport'));    
    await tester.tap(addInspeksiInkWell);    
    await tester.pumpAndSettle();    
    expect(find.text('Tambah Laporan'),
        findsOneWidget); 
  });

  testWidgets('Navigation from HomePageGA to ReportList',
      (WidgetTester tester) async {
    final firestore = FakeFirebaseFirestore();
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<ListDataProvider>(
            create: (_) => ListDataProvider(firestore: firestore),
          ),          
        ],
        child: const MaterialApp(
          home: HomePageGA(),
        ),
      ),
    );    
    expect(find.text('Inspeksi'), findsOneWidget);    
    final listInspeksiInkWell = find.byKey(const Key('key_ListReport'));
    await tester.tap(listInspeksiInkWell);    
    await tester.pumpAndSettle();    
    expect(find.text('Daftar Laporan'),
        findsOneWidget); 
  });

  testWidgets('Navigation from SelectionPage to AuthPage when isSignedIn is false',  
  (WidgetTester tester) async {       
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(
            create: (_) => MockAuthProvider(false),
          ),          
        ],
        child: const MaterialApp(
          home: SelectionPage(),
        ),
      ),
    );
    expect(find.text('Cek Spesifikasi'), findsOneWidget);
    final spekInkWell = find.byKey(const Key('key_AuthPage'));
    await tester.tap(spekInkWell);
    await tester.pumpAndSettle();
    expect(find.text('Login'), findsOneWidget);
  }
);

testWidgets('Navigation from AuthPage to HomePageMaintenanceGuest',
      (WidgetTester tester) async {    
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(
            create: (_) => AuthProvider(),
          ),          
        ],
        child: const MaterialApp(
          home: AuthPage(),
        ),
      ),
    );      
    final guestPage = find.byKey(const Key('key_guest'));    
    await tester.tap(guestPage);    
    await tester.pumpAndSettle();    
    expect(find.byKey(const Key("key_stackGuest")),
        findsOneWidget); 
  });

testWidgets('Navigation from HomePageMaintenanceGuest to ScanPage',
      (WidgetTester tester) async {    
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<EditMaintenanceProvider>(
            create: (_) => EditMaintenanceProvider(firebaseService: MockFirebaseService()),
          ),          
        ],
        child: const MaterialApp(
          home: HomePageMaintenanceGuest(),
        ),
      ));    
    final qrPage = find.byKey(const Key('key_qrPage'));    
    await tester.tap(qrPage);    
    await tester.pumpAndSettle();    
    expect(find.byKey(const Key("key_scanQR")),
        findsOneWidget); 
  });

  testWidgets('Navigation from HomePageMaintenance to ScanPage',
      (WidgetTester tester) async {    
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<EditMaintenanceProvider>(
            create: (_) => EditMaintenanceProvider(firebaseService: MockFirebaseService()),
          ),          
        ],
        child: const MaterialApp(
          home: HomePageMaintenance(),
        ),
      ));    
    final qrPage = find.byKey(const Key('key_gaQRPage'));    
    await tester.tap(qrPage);    
    await tester.pumpAndSettle();    
    expect(find.byKey(const Key("key_scanQR")),
        findsOneWidget); 
  });

  testWidgets('Navigation from HomePageMaintenance to AddDataMaintenance',
      (WidgetTester tester) async {    
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<AddMaintenanceProvider>(
            create: (_) => AddMaintenanceProvider(firebaseService: MockFirebaseService()),
          ),          
        ],
        child: const MaterialApp(
          home: HomePageMaintenance(),
        ),
      ));    
    final qrPage = find.byKey(const Key('key_addMaintenancePage'));    
    await tester.tap(qrPage);    
    await tester.pumpAndSettle();    
    expect(find.byType(FloatingActionButton),findsOneWidget);
  });

  testWidgets('Navigation from ReportList to EditReport', (WidgetTester tester) async {
  final firestore = FakeFirebaseFirestore();
  final data = {
    'date': '2023-10-12',
    'number': 'INS-2023-1',
    'found': 'Kaca Pecah',
    'dueDate': '2023-10-15',
    'progress': 'Open',
    'status': 'No Need Update',
    'no SPK': '001123',
    'location': 'Lantai 5',
    'information': 'SPK',
    'link before': '',
    'link after': '',
    'timestamp': Timestamp.fromDate(DateTime.now()), // You can adjust the date as needed
    'year': 2023,
    'pic': 'Others',
    'category': 'Others',
    'sub-category': 'Others',
  };

  firestore.collection('data').add(data);
  await tester.pumpWidget(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ListDataProvider>(
          create: (_) => ListDataProvider(firestore: firestore),
        ),
        ChangeNotifierProvider<EditDataProvider>(
          create: (_) => EditDataProvider(firebaseService: MockFirebaseService()),
        ),
      ],
      child: const MaterialApp(
        home: ReportList(),
      ),
    ),
  );
  
  expect(find.byType(CircularProgressIndicator), findsOneWidget);  
  await tester.pumpAndSettle();    
  final editPage = find.byKey(const Key("key_list_0"));
  expect(editPage, findsOneWidget);
  await tester.tap(editPage);
  await tester.pumpAndSettle();
  expect(find.text("Edit Report"),findsOneWidget);
});

testWidgets('Navigation from ReportList to PrintCSV', (WidgetTester tester) async {
  final firestore = FakeFirebaseFirestore(); 
  await tester.pumpWidget(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ListDataProvider>(
          create: (_) => ListDataProvider(firestore: firestore),
        ),        
      ],
      child: const MaterialApp(
        home: ReportList(),
      ),
    ),
  );  
  expect(find.byType(CircularProgressIndicator), findsOneWidget);  
  await tester.pumpAndSettle();    
  final printPage = find.byKey(const Key("key_print"));
  expect(printPage, findsOneWidget);
  await tester.tap(printPage);
  await tester.pumpAndSettle();
  expect(find.text("Data yang Dieksport"),findsOneWidget);
});
  });
}
