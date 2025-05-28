import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/Berita.dart';
import 'package:sina_mobile/View/Component/CardPengumuman.dart';
import 'package:sina_mobile/View/Murid/PengumumanDetail.dart';
import 'package:sina_mobile/View/Murid/PengumumanDetailMurid.dart';

import 'Component/CustomAppBar.dart';
import 'Component/Custom_drawer.dart';

class Pengumuman extends StatefulWidget{

  @override
  State<Pengumuman> createState() => _PengumumanState();
}

class _PengumumanState extends State<Pengumuman> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String currentMenu = 'pengumuman';

  final List<Berita> dummyBerita = [
    Berita(
      beritaId: 3,
      judul: 'Peringatan Hari Pendidikan Nasional',
      foto: 'samurai.jpg',
      isi: 'Sekolah mengadakan upacara bendera dan lomba antar kelas dalam rangka memperingati Hari Pendidikan Nasional.',
      tipe: 'Informasi',
      createdAt: DateTime.parse('2025-05-02 08:00:00'),
      namaGuru: 'Ibu Sari',
      namaAdmin: null,
    ),
    Berita(
      beritaId: 4,
      judul: 'Pengumuman Libur Semester',
      foto: 'samurai.jpg',
      isi: 'Diumumkan kepada seluruh siswa bahwa libur semester akan dimulai tanggal 10 Juni 2025 hingga 20 Juli 2025.',
      tipe: 'Pengumuman',
      createdAt: DateTime.parse('2025-05-25 10:30:00'),
      namaGuru: null,
      namaAdmin: 'Admin Sekolah',
    ),
  ];


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: dummyBerita.length,
        itemBuilder: (context, index) {
          final beritaItem = dummyBerita[index];
          return CardPengumuman(
            berita: beritaItem,
            Action: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PengumumanDetailMurid(
                    berita: beritaItem,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}