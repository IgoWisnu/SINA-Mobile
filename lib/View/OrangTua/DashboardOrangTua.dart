import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart'; // <== Tambahkan
import 'package:sina_mobile/View/Component/Box.dart';
import 'package:sina_mobile/View/Component/OrangTua/CustomAppBarOrangTua.dart';
import 'package:sina_mobile/View/Component/OrangTua/CustomOrangTuaDrawer.dart';
import 'package:sina_mobile/View/Component/TitleBar.dart';
import 'package:sina_mobile/View/OrangTua/NotificationPage.dart';
import 'package:sina_mobile/View/OrangTua/PengumumanOrtuDashboard.dart';
import 'package:sina_mobile/Model/OrangTua/Siswa.dart';
import 'package:sina_mobile/service/api/ApiServisOrangTua.dart';
import 'package:sina_mobile/service/repository/OrangTua/DaftarSiswaRepository.dart';
import 'package:sina_mobile/ViewModel/OrangTua/DashboardOrtuViewModel.dart';

class Dashboardorangtua extends StatefulWidget {
  Dashboardorangtua({super.key});

  @override
  State<Dashboardorangtua> createState() => _DashboardorangtuaState();
}

class _DashboardorangtuaState extends State<Dashboardorangtua> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String currentMenu = 'dashboardortu';

  List<Siswa> siswaList = [];
  Siswa? selectedSiswa;

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
          selectedSiswa = data.first;
        }
      });

      if (data.isNotEmpty) {
        // ✅ Simpan NIS siswa pertama ke SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('nis', data.first.nis);
        await prefs.setString('krs_id', data.first.krsId);

        final dashboardVM = Provider.of<DashboardOrtuViewModel>(
          context,
          listen: false,
        );
        dashboardVM.fetchDashboard(data.first.nis);
      }
    } catch (e) {
      print("Gagal memuat siswa: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<DashboardOrtuViewModel>(context);
    final data = vm.dashboard;

    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomOrangTuaDrawer(selectedMenu: currentMenu),
      appBar: CustomAppBarOrangTua(
        onMenuPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      body:
          data == null
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Ringkasan Box
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Box(
                          jumlah: data.tugasBelumDikerjakan,
                          keterangan: 'Tugas Belum Dikerjakan',
                        ),
                        const SizedBox(width: 10),
                        Box(
                          jumlah: data.absensiTidakHadir,
                          keterangan: 'Absensi Tidak Hadir',
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Box(
                          jumlah: data.tugasTerlambat,
                          keterangan: 'Tugas Terlambat',
                        ),
                        const SizedBox(width: 10),
                        Box(
                          jumlah: data.materiHariIni,
                          keterangan: 'Materi Hari Ini',
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Notifikasi Anak
                    Text(
                      'Notifikasi Anak',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Dropdown siswa
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<Siswa>(
                          isExpanded: true,
                          value: selectedSiswa,
                          hint: Text("Pilih Anak"),
                          items:
                              siswaList.map((siswa) {
                                return DropdownMenuItem<Siswa>(
                                  value: siswa,
                                  child: Text(siswa.namaSiswa),
                                );
                              }).toList(),
                          onChanged: (value) async {
                            setState(() {
                              selectedSiswa = value;
                            });

                            if (value != null) {
                              // ✅ Simpan NIS saat user memilih siswa dari dropdown
                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setString('nis', value.nis);
                              await prefs.setString('krs_id', value.krsId);

                              Provider.of<DashboardOrtuViewModel>(
                                context,
                                listen: false,
                              ).fetchDashboard(value.nis);
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Box info siswa
                    if (selectedSiswa != null)
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color(0xFFDFF5E1), // Warna hijau pastel elegan
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.person, color: Colors.green.shade800),
                            SizedBox(width: 10),
                            Expanded(
                              // Expanded agar tidak overflow
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Mulyanto Puspasari',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green.shade900,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'NIS: 1001003019',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.green.shade700,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Belum mengisi absensi',

                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      SizedBox(height: 20),
                    TitleBar(judul: 'Pengumuman'),
                    const SizedBox(height: 10),
                    PengumumanOrtuDashboard(),
                  ],
                ),
              ),
    );
  }
}
