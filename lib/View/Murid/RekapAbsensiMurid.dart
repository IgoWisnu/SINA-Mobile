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

class RekapAbsensiMurid extends StatefulWidget {
  RekapAbsensiMurid({super.key});

  @override
  State<RekapAbsensiMurid> createState() => _RekapAbsensiMuridState();


}

class _RekapAbsensiMuridState extends State<RekapAbsensiMurid> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String currentMenu = 'rekap';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // ← INI YANG BELUM ADA
      drawer: CustomMuridDrawer(
        selectedMenu: currentMenu,
      ),
      appBar: CustomAppBar(
        onMenuPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                height: 250,
                child: PieChart(
                  PieChartData(
                    //centerSpaceRadius: 0,
                    sections: [
                      PieChartSectionData(
                        value: 40,
                        title: '40%',
                        color: Colors.blue,
                        radius: 50,
                      ),
                      PieChartSectionData(
                        value: 30,
                        title: '30%',
                        color: Colors.red,
                        radius: 50,
                      ),
                      PieChartSectionData(
                        value: 20,
                        title: '20%',
                        color: Colors.green,
                        radius: 50,
                      ),
                      PieChartSectionData(
                        value: 10,
                        title: '10%',
                        color: Colors.orange,
                        radius: 50,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 36,
                          height: 24,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5)
                          ),
                        ),
                        SizedBox(width: 3,),
                        Text("Hadir: 320")
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 36,
                          height: 24,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(5)
                          ),
                        ),
                        SizedBox(width: 3,),
                        Text("Sakit: 10")
                      ],
                    ),
                  ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 36,
                        height: 24,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(5)
                        ),
                      ),
                      SizedBox(width: 3,),
                      Text("Izin: 20")
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 36,
                        height: 24,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(5)
                        ),
                      ),
                      SizedBox(width: 3,),
                      Text("Alpa: 30")
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20,),
              TitleBar(judul: "Riwayat Absensi"),
              ItemRiwayatAbsensi(),
              ItemRiwayatAbsensi(),
              ItemRiwayatAbsensi(),
              SizedBox(height: 20,),
              RegularButton(onTap: (){}, judul: "Lebih Banyak",)
            ],
          ),
        ),
      ),
    );
  }
}