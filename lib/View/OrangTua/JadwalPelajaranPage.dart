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

    // Atur default hari sesuai hari ini (jika weekday 1-5)
    final today = DateTime.now().weekday;
    if (today >= 1 && today <= 5) {
      selectedItem = hariList[today - 1];
    }

    // Ambil data jadwal
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomDropdownOrtu(
                  items: hariList,
                  selectedItem: selectedItem,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => selectedItem = value);
                      vm.fetchJadwal(selectedItem);
                    }
                  },
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Judul kolom
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              width: double.infinity,
              color: AppColors.primary,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Waktu',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Mata Pelajaran',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Guru',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Konten list
            Expanded(
              child: Builder(
                builder: (_) {
                  if (vm.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (vm.error != null) {
                    return Center(child: Text('Error: ${vm.error}'));
                  } else if (vm.jadwalList.isEmpty) {
                    return const Center(child: Text('Tidak ada jadwal.'));
                  } else {
                    return ListView.builder(
                      itemCount: vm.jadwalList.length,
                      itemBuilder: (context, index) {
                        final j = vm.jadwalList[index];
                        return ItemJadwalOrtu(
                          waktu_mulai: j.start,
                          waktu_selesai: j.finish,
                          mata_pelajaran: j.namaMapel,
                          guru: j.namaGuru,
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
    );
  }
}
