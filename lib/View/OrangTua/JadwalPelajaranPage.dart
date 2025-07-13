import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sina_mobile/View/Component/OrangTua/ItemJadwalOrtu.dart';
import 'package:sina_mobile/View/Component/OrangTua/CustomDropdownOrtu.dart';
import 'package:sina_mobile/View/Component/OrangTua/CustomAppBarOrangTua.dart';
import 'package:sina_mobile/View/Component/OrangTua/CustomOrangTuaDrawer.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';
import 'package:sina_mobile/ViewModel/OrangTua/JadwalHarianVIewModel.dart';

class JadwalPelajaranPage extends StatefulWidget {
  @override
  State<JadwalPelajaranPage> createState() => _JadwalPelajaranPageState();
}

class _JadwalPelajaranPageState extends State<JadwalPelajaranPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String currentMenu = 'jadwal_pelajaran';
  String selectedItem = 'senin';
  final List<String> hariList = ['senin', 'selasa', 'rabu', 'kamis', 'jumat'];

  @override
  void initState() {
    super.initState();
    final today = DateTime.now().weekday;
    if (today >= 1 && today <= 5) {
      selectedItem = hariList[today - 1];
    }
    Future.microtask(() {
      final vm = Provider.of<JadwalHarianViewModel>(context, listen: false);
      vm.fetchJadwal(selectedItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<JadwalHarianViewModel>(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomOrangTuaDrawer(selectedMenu: currentMenu),
      appBar: CustomAppBarOrangTua(
        onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.grey[50]!],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Header dengan shadow
              Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(12),
                shadowColor: AppColors.primary.withOpacity(0.2),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomDropdownOrtu(
                          items: hariList,
                          selectedItem: selectedItem,
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => selectedItem = value);
                              vm.fetchJadwal(selectedItem);
                            }
                          },
                        ),
                      ),
                      Icon(Icons.calendar_today, color: AppColors.primary),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Judul kolom dengan efek lebih modern
              Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary,
                        AppColors.primary.withOpacity(0.8),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Waktu',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Text(
                          'Mata Pelajaran',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Guru',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Konten list dengan shadow
              Expanded(
                child: Builder(
                  builder: (_) {
                    if (vm.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primary,
                          ),
                        ),
                      );
                    } else if (vm.error != null) {
                      return Center(
                        child: Material(
                          elevation: 2,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Error: ${vm.error}',
                              style: TextStyle(
                                color: Colors.red[700],
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      );
                    } else if (vm.jadwalList.isEmpty) {
                      return Center(
                        child: Material(
                          elevation: 2,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              'Tidak ada jadwal hari ini',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: vm.jadwalList.length,
                        itemBuilder: (context, index) {
                          final j = vm.jadwalList[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Material(
                              elevation: 2,
                              borderRadius: BorderRadius.circular(8),
                              shadowColor: Colors.grey.withOpacity(0.2),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: ItemJadwalOrtu(
                                  waktu_mulai: j.jam
                                      .split('-')[0]
                                      .substring(0, 5),
                                  waktu_selesai: j.jam
                                      .split('-')[1]
                                      .substring(0, 5),
                                  mata_pelajaran: j.mataPelajaran,
                                  guru: j.guru,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
