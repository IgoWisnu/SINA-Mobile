import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/Box.dart';
import 'package:sina_mobile/View/Component/ClassCard.dart';
import 'package:sina_mobile/View/Component/CustomAppBar.dart';
import 'package:sina_mobile/View/Component/ItemTugas.dart';
import 'package:sina_mobile/View/Component/Murid/CustomMuridDrawer.dart';
import 'package:sina_mobile/View/Component/Murid/ItemRapotMurid.dart';
import 'package:sina_mobile/View/Component/Murid/ItemRiwayatAbsensi.dart';
import 'package:sina_mobile/View/Component/RegularButton.dart';
import 'package:sina_mobile/View/Component/TitleBar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sina_mobile/ViewModel/RekapAbsensiViewModel.dart';
import 'package:provider/provider.dart';

class RekapAbsensiMurid extends StatefulWidget {
  RekapAbsensiMurid({super.key});

  @override
  State<RekapAbsensiMurid> createState() => _RekapAbsensiMuridState();
}

class _RekapAbsensiMuridState extends State<RekapAbsensiMurid> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String currentMenu = 'rekap';

  double dummyHadir = 5;
  double dummyIzin = 2;

  @override
  void initState() {
    super.initState();
    // Ambil data kelas saat widget dibuka
    Future.microtask(
      () =>
          Provider.of<RekapAbsensiViewModel>(
            context,
            listen: false,
          ).getRekapAbsen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<RekapAbsensiViewModel>(context);

    return Scaffold(
      key: _scaffoldKey, // ← INI YANG BELUM ADA
      drawer: CustomMuridDrawer(selectedMenu: currentMenu),
      appBar: CustomAppBar(
        onMenuPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              vm.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : vm.error != null
                  ? Center(child: Text('Error: ${vm.error}'))
                  : vm.rekapabsendata == null
                  ? Center(child: Text('Data tidak tersedia'))
                  : Column(
                    children: [
                      Container(
                        height: 250,
                        child: PieChart(
                          PieChartData(
                            sections: [
                              PieChartSectionData(
                                value:
                                    vm.rekapabsendata!.hadir.toDouble() +
                                    dummyHadir,
                                title:
                                    '${vm.rekapabsendata!.hadir + dummyHadir} Hadir',
                                color: Colors.blue,
                                radius: 50,
                                titleStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              PieChartSectionData(
                                value:
                                    vm.rekapabsendata!.izin.toDouble() +
                                    dummyIzin,
                                title:
                                    '${vm.rekapabsendata!.izin + dummyIzin} Izin',
                                color: Colors.green,
                                radius: 50,
                                titleStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              PieChartSectionData(
                                value: vm.rekapabsendata!.sakit.toDouble(),
                                title: '${vm.rekapabsendata!.sakit} Sakit',
                                color: Colors.yellow,
                                radius: 50,
                                titleStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              PieChartSectionData(
                                value: vm.rekapabsendata!.alpha.toDouble(),
                                title: '${vm.rekapabsendata!.alpha} Alpha',
                                color: Colors.red,
                                radius: 50,
                                titleStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 36,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              SizedBox(width: 3),
                              Text(
                                "Hadir: ${vm.rekapabsendata!.hadir + dummyHadir}",
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 36,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              SizedBox(width: 3),
                              Text("Sakit: ${vm.rekapabsendata!.sakit}"),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 36,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              SizedBox(width: 3),
                              Text(
                                "Izin: ${vm.rekapabsendata!.izin + dummyIzin}",
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 36,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              SizedBox(width: 3),
                              Text("Alpha: ${vm.rekapabsendata!.alpha}"),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      TitleBar(judul: "Riwayat Absensi"),
                      ItemRiwayatAbsensi(),
                      ItemRiwayatAbsensi(),
                      ItemRiwayatAbsensi(),
                      SizedBox(height: 20),
                      RegularButton(onTap: () {}, judul: "Lebih Banyak"),
                    ],
                  ),
        ),
      ),
    );
  }
}
