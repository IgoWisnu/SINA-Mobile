import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/Box.dart';
import 'package:sina_mobile/View/Component/ClassCard.dart';
import 'package:sina_mobile/View/Component/CustomAppBar.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/Custom_drawer.dart';
import 'package:sina_mobile/View/Component/ItemAbsensi.dart';
import 'package:sina_mobile/View/Component/ItemTugas.dart';
import 'package:sina_mobile/View/Component/Murid/CustomMuridDrawer.dart';
import 'package:sina_mobile/View/Component/Murid/ItemTugasMurid.dart';
import 'package:sina_mobile/View/Component/TitleAbsensi.dart';
import 'package:sina_mobile/View/Component/TitleBar.dart';
import 'package:sina_mobile/View/TugasDetail.dart';
import 'package:sina_mobile/ViewModel/DashboardViewModel.dart';
import 'package:provider/provider.dart';

class DashboardMurid extends StatefulWidget {
  DashboardMurid({super.key});

  @override
  State<DashboardMurid> createState() => _DashboardMuridState();


}

class _DashboardMuridState extends State<DashboardMurid> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String currentMenu = 'dashboard';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final vm = Provider.of<DashboardViewModel>(context, listen: false);
      vm.fetchDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<DashboardViewModel>(context);
    final status = vm.dashboard;

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
      body: status == null
          ? Center(child: CircularProgressIndicator())
          :SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Box(jumlah: status.tugasBelumDikerjakan, keterangan: 'Tugas Belum Dikerjakan',),
                    const SizedBox(width: 10),
                    Box(jumlah: status.absensiTidakHadir, keterangan: 'Absensi Tidak Hadir',),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Box(jumlah: status.tugasTerlambat, keterangan: 'Tugas Terlambat',),
                    const SizedBox(width: 10),
                    Box(jumlah: 2, keterangan: 'Materi Hari Ini',),
                  ],
                ),
                SizedBox(height: 20,),
                TitleBar(judul: "Tugas Terbaru"),
                ItemTugasMurid(
                    judul: "Tugas Javascript 3",
                    upload_date: DateTime(2024, 5, 20),
                    tenggat: DateTime(2024, 5, 23),
                    onTap: (){
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => TugasDetail()),
                      // );
                    }
                ),
                ItemTugasMurid(
                    judul: "Tugas Javascript 2",
                    upload_date: DateTime(2025, 5, 2),
                    tenggat: DateTime(2025, 5, 15),
                    onTap: (){
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => TugasDetail()),
                      // );
                    }
                ),
                ItemTugasMurid(
                    judul: "Tugas Javascript 1",
                    upload_date: DateTime(2025, 4, 29),
                    tenggat: DateTime(2025, 5, 2),
                    onTap: (){
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => TugasDetail()),
                      // );
                    }
                ),
                SizedBox(height: 20,),
                Text("Kelas Hari Ini", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                SizedBox(height: 10,),
                ClassCard(judul: "Matematika/X.1", onTap: (){}),
                SizedBox(height: 5,),
                ClassCard(judul: "Matematika/X.1", onTap: (){}),
                SizedBox(height: 5,),
                ClassCard(judul: "Matematika/X.1", onTap: (){}),
                SizedBox(height: 5,),
              ],
            ),
          ),
      ),
    );
  }
}