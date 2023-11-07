import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:juling_apps/model/model_maintenance.dart';
import 'package:juling_apps/provider/list_mantenance.dart';

class InfoPageGuest extends StatelessWidget {
  final String id;

  const InfoPageGuest({Key? key, required this.id}) : super(key: key);

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
        ),
      ),
      body: Consumer<MaintenanceDataProvider>(
        builder: (context, value, child) {
          return StreamBuilder<List<MaintenanceData>>(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                MaintenanceData data =
                    snapshot.data!.firstWhere((element) => element.id == id);

                return Stack(
                  children: [
                    SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: SvgPicture.asset(
                        "assets/auth.svg",
                        fit: BoxFit.fill,
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          data.url != ""
                              ? Container(
                                  height: 350,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(40),
                                      bottomRight: Radius.circular(40),
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        data.url,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 350,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(40),
                                      bottomRight: Radius.circular(40),
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text("Belum ada foto"),
                                  ),
                                ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                data.id,
                                style: const TextStyle(fontSize: 30),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "Spesifikasi:",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                data.spesifikasi.join("\n"),
                                style: const TextStyle(fontSize: 15),
                              )),
                          const SizedBox(
                            height: 20,
                          ),                          
                        ],
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
            stream: value.getMaintenanceData(),
          );
        },
      ),
    );
  }
}
