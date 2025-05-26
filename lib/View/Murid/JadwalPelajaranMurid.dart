import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/Box.dart';
import 'package:sina_mobile/View/Component/ClassCard.dart';
import 'package:sina_mobile/View/Component/CustomAppBar.dart';
import 'package:sina_mobile/View/Component/ItemTugas.dart';
import 'package:sina_mobile/View/Component/Murid/CustomMuridDrawer.dart';
import 'package:sina_mobile/View/Component/Murid/ItemJadwalMurid.dart';
import 'package:sina_mobile/View/Component/TitleBar.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';
import 'package:provider/provider.dart';
import 'package:sina_mobile/ViewModel/JadwalViewModel.dart';
import 'package:sina_mobile/ViewModel/KelasDetailViewModel.dart';

class JadwalPelajaranMurid extends StatefulWidget {
  JadwalPelajaranMurid({super.key});

  @override
  State<JadwalPelajaranMurid> createState() => _JadwalPelajaranMuridState();


}

class _JadwalPelajaranMuridState extends State<JadwalPelajaranMurid> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String currentMenu = 'jadwal';

  @override
  void initState() {
    super.initState();
    // Ambil data kelas saat widget dibuka
    Future.microtask(() {
      final vm = Provider.of<JadwalViewModel>(context, listen: false);
      vm.fetchJadwal();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<JadwalViewModel>(context, listen: false);

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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Waktu", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                    Text("Mata Pelajaran", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                    Text("Guru Mengajar", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                  ],
                  ),
                ),
              ),
        vm.isLoading
            ? const Center(child: CircularProgressIndicator())
            : vm.error != null
            ? Center(child: Text('Error: ${vm.error}'))
            : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(), // agar tidak konflik dengan SingleChildScrollView
                itemCount: vm.jadwalList.length,
                itemBuilder: (context, index) {
                  final jadwal = vm.jadwalList[index];
                  return ItemJadwalMurid(
                    waktu_mulai: jadwal.start,
                    waktu_selesai: jadwal.finish,
                    mata_pelajaran: jadwal.namaMapel,
                    guru: jadwal.namaGuru,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}