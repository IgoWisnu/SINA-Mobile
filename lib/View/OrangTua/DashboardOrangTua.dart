import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/Box.dart';
import 'package:sina_mobile/View/Component/CustomAppBar.dart';
import 'package:sina_mobile/View/OrangTua/NotificationPage.dart';
import 'package:sina_mobile/View/Component/OrangTua/CustomOrangTuaDrawer.dart';
import 'package:sina_mobile/View/Component/TitleBar.dart';
import 'package:sina_mobile/View/OrangTua/PengumumanOrtuDashboard.dart';
import 'package:sina_mobile/Model/OrangTua/Siswa.dart';
import 'package:sina_mobile/service/repository/OrangTua/DaftarSiswaRepository.dart';
import 'package:sina_mobile/service/api/ApiServisOrangTua.dart';

class Dashboardorangtua extends StatefulWidget {
  Dashboardorangtua({super.key});

  @override
  State<Dashboardorangtua> createState() => _DashboardorangtuaState();
}

class _DashboardorangtuaState extends State<Dashboardorangtua> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String currentMenu = 'dashboardortu';

  List<Siswa> siswaList = [];
  String? selectedNamaSiswa;

  @override
  void initState() {
    super.initState();
    fetchDaftarSiswa();
  }

  Future<void> fetchDaftarSiswa() async {
    try {
      final repo = DaftarSiswaRepository(ApiServiceOrangTua());
      final data = await repo.fetchSiswaByOrtu();

      setState(() {
        siswaList = data;
        if (data.isNotEmpty) {
          selectedNamaSiswa = data.first.namaSiswa;
        }
      });
    } catch (e) {
      print("Gagal memuat siswa: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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

              /// NOTIFIKASI ANAK
              Text(
                'Notifikasi Anak',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 10),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedNamaSiswa,
                    hint: Text("Pilih Anak"),
                    items:
                        siswaList.map((siswa) {
                          return DropdownMenuItem<String>(
                            value: siswa.namaSiswa,
                            child: Text(siswa.namaSiswa),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedNamaSiswa = value;
                      });
                    },
                  ),
                ),
              ),

              SizedBox(height: 10),

              if (selectedNamaSiswa != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green[400],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedNamaSiswa!,
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "Hadir", // placeholder, bisa ganti jika ada status absensi
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 20),
              TitleBar(judul: 'Pengumuman'),
              const SizedBox(height: 10),
              PengumumanOrtuDashboard(),
            ],
          ),
        ),
      ),
    );
  }
}
