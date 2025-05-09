import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/Box.dart';
import 'package:sina_mobile/View/Component/ClassCard.dart';
import 'package:sina_mobile/View/Component/CustomAppBar.dart';
import 'package:sina_mobile/View/Component/ItemTugas.dart';
import 'package:sina_mobile/View/Component/Murid/CustomMuridDrawer.dart';
import 'package:sina_mobile/View/Component/Murid/ItemJadwalMurid.dart';
import 'package:sina_mobile/View/Component/TitleBar.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';

class JadwalPelajaranMurid extends StatefulWidget {
  JadwalPelajaranMurid({super.key});

  @override
  State<JadwalPelajaranMurid> createState() => _JadwalPelajaranMuridState();


}

class _JadwalPelajaranMuridState extends State<JadwalPelajaranMurid> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String currentMenu = 'jadwal';

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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.primary
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Waktu", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                  Text("Mata Pelajaran", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                  Text("Guru Mengajar", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                ],
                ),
              ),
              ItemJadwalMurid(waktu_mulai: "08.00", waktu_selesai: "09.45", mata_pelajaran: "Matematika", guru: "Oscar Piastri"),
              ItemJadwalMurid(waktu_mulai: "08.00", waktu_selesai: "09.45", mata_pelajaran: "Matematika", guru: "Oscar Piastri"),
              ItemJadwalMurid(waktu_mulai: "08.00", waktu_selesai: "09.45", mata_pelajaran: "Matematika", guru: "Oscar Piastri"),
              ItemJadwalMurid(waktu_mulai: "08.00", waktu_selesai: "09.45", mata_pelajaran: "Matematika", guru: "Oscar Piastri"),
            ],
          ),
        ),
      ),
    );
  }
}