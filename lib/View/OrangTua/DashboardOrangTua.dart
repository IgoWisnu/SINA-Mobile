import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/View/Component/Box.dart';
import 'package:sina_mobile/View/Component/OrangTua/CustomAppBarOrangTua.dart';
import 'package:sina_mobile/View/Component/OrangTua/CustomOrangTuaDrawer.dart';
import 'package:sina_mobile/View/Component/TitleBar.dart';
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
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Ringkasan Boxes
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

                    // Notifikasi Anak Section
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Notifikasi Anak',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Dropdown Anak
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<Siswa>(
                                isExpanded: true,
                                value: selectedSiswa,
                                hint: const Text("Pilih Anak"),
                                items:
                                    siswaList.map((siswa) {
                                      return DropdownMenuItem<Siswa>(
                                        value: siswa,
                                        child: Text(
                                          siswa.nama,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      );
                                    }).toList(),
                                onChanged: (value) async {
                                  setState(() {
                                    selectedSiswa = value;
                                  });

                                  if (value != null) {
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.setString('nis', value.nis);
                                    await prefs.setString(
                                      'krs_id',
                                      value.krsId,
                                    );

                                    Provider.of<DashboardOrtuViewModel>(
                                      context,
                                      listen: false,
                                    ).fetchDashboard(value.nis);
                                  }
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),

                          // Student Info Card
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.green.shade100),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade100,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.person,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        vm.dashboard?.notifikasiAnak.nama ??
                                            '-',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'NIS: ${selectedSiswa?.nis ?? '-'}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              vm
                                                          .dashboard
                                                          ?.notifikasiAnak
                                                          .statusKehadiran ==
                                                      'Hadir'
                                                  ? Colors.green.shade100
                                                  : Colors.red.shade100,
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        child: Text(
                                          vm
                                                  .dashboard
                                                  ?.notifikasiAnak
                                                  .statusKehadiran ??
                                              '',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                vm
                                                            .dashboard
                                                            ?.notifikasiAnak
                                                            .statusKehadiran ==
                                                        'Hadir'
                                                    ? Colors.green.shade800
                                                    : Colors.red.shade800,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const TitleBar(judul: 'Pengumuman'),
                    const SizedBox(height: 10),
                    PengumumanOrtuDashboard(),
                  ],
                ),
              ),
    );
  }
}
