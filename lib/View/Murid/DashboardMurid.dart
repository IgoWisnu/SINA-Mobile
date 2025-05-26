import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/Box.dart';
import 'package:sina_mobile/View/Component/ClassCard.dart';
import 'package:sina_mobile/View/Component/CustomAppBar.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/Custom_drawer.dart';
import 'package:sina_mobile/View/Component/ItemAbsensi.dart';
import 'package:sina_mobile/View/Component/ItemTugas.dart';
import 'package:sina_mobile/View/Component/Murid/CustomMuridDrawer.dart';
import 'package:sina_mobile/View/Component/TitleAbsensi.dart';
import 'package:sina_mobile/View/Component/TitleBar.dart';

class DashboardMurid extends StatefulWidget {
  DashboardMurid({super.key});

  @override
  State<DashboardMurid> createState() => _DashboardMuridState();


}

class _DashboardMuridState extends State<DashboardMurid> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String currentMenu = 'dashboard';

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Box(jumlah: 5, keterangan: 'Tugas Belum Dikerjakan',),
                  const SizedBox(width: 10),
                  Box(jumlah: 24, keterangan: 'Absensi Tidak Hadir',),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Box(jumlah: 6, keterangan: 'Tugas Terlambat',),
                  const SizedBox(width: 10),
                  Box(jumlah: 2, keterangan: 'Materi Hari Ini',),
                ],
              ),
              SizedBox(height: 20,),
              TitleBar(judul: "Tugas Terbaru"),
              ItemTugas(),
              ItemTugas(),
              ItemTugas(),
              SizedBox(height: 20,),
              Text("Kelas Hari Ini", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              SizedBox(height: 10,),
              ClassCard(judul: "Matematika/X.1", onTap: (){}),
              SizedBox(height: 5,),
              ClassCard(judul: "Matematika/X.1", onTap: (){}),
              SizedBox(height: 5,),
              ClassCard(judul: "Matematika/X.1", onTap: (){}),
              SizedBox(height: 5,),
            ],
          ),
        ),
      ),
    );
  }
}