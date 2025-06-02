import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/Box.dart';

import 'package:sina_mobile/View/Component/CustomAppBar.dart';
import 'package:sina_mobile/View/OrangTua/NotificationPage.dart';

import 'package:sina_mobile/View/Component/OrangTua/CustomOrangTuaDrawer.dart';
import 'package:sina_mobile/View/OrangTua/PengumumanOrangTuaDashboard.dart';

import 'package:sina_mobile/View/Component/TitleBar.dart';

class Dashboardorangtua extends StatefulWidget {
  Dashboardorangtua({super.key});

  @override
  State<Dashboardorangtua> createState() => _DashboardorangtuaState();
}

class _DashboardorangtuaState extends State<Dashboardorangtua> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String currentMenu = 'dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // ← INI YANG BELUM ADA
      drawer: CustomOrangTuaDrawer(selectedMenu: currentMenu),
      appBar: CustomAppBar(
        onMenuPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Box(jumlah: 4, keterangan: 'Tugas Belum Dikerjakan'),
                  const SizedBox(width: 10),
                  Box(jumlah: 3, keterangan: 'Absensi Tidak Hadir'),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Box(jumlah: 1, keterangan: 'Tugas Terlambat'),
                  const SizedBox(width: 10),
                  Box(jumlah: 4, keterangan: 'Materi Hari Ini'),
                ],
              ),
              const SizedBox(height: 20),
              Column(children: [NotifikasiAnak()]),
              TitleBar(judul: 'Pengumuman'),
              PengumumanOrangTua(),
              PengumumanOrangTua(),
              PengumumanOrangTua(),
            ],
          ),
        ),
      ),
    );
  }
}
