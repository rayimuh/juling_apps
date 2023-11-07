import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:juling_apps/maintenance/maintenance_auth_page/info_page.dart';
import 'package:juling_apps/maintenance/maintenance_guest_page/info_page_guest.dart';
import 'package:juling_apps/provider/auth_user.dart';
import 'package:juling_apps/provider/edit_maintenance.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {  

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
            bottomOpacity: 0.0,
            elevation: 0.0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  context.read<EditMaintenanceProvider>().reset();
                });
                Navigator.pop(context);                
              },
            )),
      body: Consumer<EditMaintenanceProvider>(builder:(context, value, child) {
        return Stack(key: const Key("key_scanQR"),children: [
        SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: SvgPicture.asset(
              "assets/add_report.svg",
              fit: BoxFit.fill,
            )),
        Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
            Text(context.read<EditMaintenanceProvider>().barcode),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.center,children: [
              ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF394B78),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80))),
              child: const Text(
                'Pindai Kode QR',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              onPressed: () {
                value.scanBarcode();
              },
            ),
            const SizedBox(width: 10),
            ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80))),
                  child: const Text(
                    'Lihat Detail',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  onPressed: () {                    
                    context.read<EditMaintenanceProvider>().barcode=="Pindai QR untuk mendapatkan data"||context.read<EditMaintenanceProvider>().barcode=="-1"||context.read<EditMaintenanceProvider>().barcode=="Gagal dalam memindai QR code"||context.read<EditMaintenanceProvider>().exist==false                 
                    ?Fluttertoast.showToast(msg: "Belum ada data")
                    :context.read<AuthProvider>().isSignedIn
                    ?Navigator.push(context, MaterialPageRoute(builder: ((context) => InfoPage(id: context.read<EditMaintenanceProvider>().barcode))))
                    :Navigator.push(context, MaterialPageRoute(builder: ((context) => InfoPageGuest(id: context.read<EditMaintenanceProvider>().barcode))));
                  },
                ),
            ],),
             
          ],
        ),
      ),
      ],);
      })
    );
  }
}
