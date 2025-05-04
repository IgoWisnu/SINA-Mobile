import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/CustomAppBar.dart';
import 'package:sina_mobile/View/Component/CustomDropdown.dart';
import 'package:sina_mobile/View/Component/Custom_drawer.dart';
import 'package:sina_mobile/View/Component/ItemJadwal.dart';
import 'package:sina_mobile/View/Component/TitleBar.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';

class JadwalGuru extends StatefulWidget{

  @override
  State<JadwalGuru> createState() => _JadwalGuruState();
}

class _JadwalGuruState extends State<JadwalGuru> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String currentMenu = 'jadwal';
  String selecteditem = 'Senin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // ← INI YANG BELUM ADA
      drawer: CustomDrawer(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomDropdown(
                  items: ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat'],
                  selectedItem: selecteditem,
                  onChanged: (newValue) {
                    setState(() {
                      selecteditem = newValue!;
                    });
                  },
              ),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Waktu", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                      Text("Mata Pelajaran", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                      Text("Kelas", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                    ],
                  ),
                ),
              ),
              ItemJadwal(waktu_mulai: "08.00", waktu_selesai: "09.45", mata_pelajaran: "Javascript", kelas: "XI.1"),
              ItemJadwal(waktu_mulai: "09.45", waktu_selesai: "10.30", mata_pelajaran: "Javascript", kelas: "XI.2"),
              ItemJadwal(waktu_mulai: "12.00", waktu_selesai: "12.45", mata_pelajaran: "Javascript", kelas: "XII.1")
            ],
          ),
        ),
      ),
    );
  }
}