import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/Box.dart';
import 'package:sina_mobile/View/Component/ClassCard.dart';
import 'package:sina_mobile/View/Component/CustomAppBar.dart';
import 'package:sina_mobile/View/Component/CustomDropdown.dart';
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
  String selectedItem = 'Senin';
  final List<String> hariList = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat'];

  int getKodeHari(String hari) {
    switch (hari) {
      case 'Senin':
        return 1;
      case 'Selasa':
        return 2;
      case 'Rabu':
        return 3;
      case 'Kamis':
        return 4;
      case 'Jumat':
        return 5;
      default:
        return 0;
    }
  }


  @override
  void initState() {
    super.initState();

    // Set selectedItem sesuai hari ini
    int today = DateTime.now().weekday; // Senin = 1, Minggu = 7
    if (today >= 1 && today <= 5) {
      selectedItem = hariList[today - 1]; // Senin = 0
    } else {
      selectedItem = 'Senin'; // default jika hari Sabtu/Minggu
    }

    // Ambil data kelas saat widget dibuka
    Future.microtask(() {
      final vm = Provider.of<JadwalViewModel>(context, listen: false);
      vm.fetchJadwal();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<JadwalViewModel>(context);
    final kodeHariDipilih = getKodeHari(selectedItem);
    final jadwalHariIni = vm.jadwalList.where((j) => j.hari == kodeHariDipilih).toList();


    return Scaffold(
      key: _scaffoldKey,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Jadwal Pelajaran", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  CustomDropdown(
                      items: ['Senin', 'Selasa','Rabu','Kamis','Jumat'],
                      selectedItem: selectedItem,
                      onChanged: (newValue) {
                        setState(() {
                          selectedItem = newValue!;
                        });
                      },
                  )
                ],
              ),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.primary
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
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
                physics: NeverScrollableScrollPhysics(),
                itemCount: jadwalHariIni.length,
                itemBuilder: (context, index) {
                  final jadwal = jadwalHariIni[index];
                  return ItemJadwalMurid(
                    waktu_mulai: jadwal.start,
                    waktu_selesai: jadwal.finish,
                    mata_pelajaran: jadwal.namaMapel,
                    guru: jadwal.namaGuru,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}