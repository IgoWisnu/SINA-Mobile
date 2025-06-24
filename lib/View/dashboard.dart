import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/Box.dart';
import 'package:sina_mobile/View/Component/CustomAppBar.dart';
import 'package:sina_mobile/View/Component/Custom_drawer.dart';
import 'package:sina_mobile/View/Component/Murid/ItemTugasMurid.dart';
import 'package:sina_mobile/View/Component/TitleBar.dart';
import 'package:sina_mobile/View/TugasDetail.dart';
import 'package:sina_mobile/ViewModel/Guru/DashboardGuruViewModel.dart';
import 'package:provider/provider.dart';

class dashboard extends StatefulWidget {
  dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();


}

class _dashboardState extends State<dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String currentMenu = 'dashboard';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final vm = Provider.of<DashboardGuruViewModel>(context, listen: false);
      vm.fetchDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<DashboardGuruViewModel>(context);
    final status = vm.dashboard;

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
      body: status == null
          ? Center(child: CircularProgressIndicator()) :
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Box(jumlah: status.uncompletedTasks, keterangan: 'Tugas Belum Dikerjakan',),
                    const SizedBox(width: 10),
                    Box(jumlah: status.absentStudents, keterangan: 'Siswa Tidak Hadir',),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Box(jumlah: status.lateSubmissions, keterangan: 'Belum mengumpulkan',),
                    const SizedBox(width: 10),
                    Box(jumlah: status.todayMaterials, keterangan: 'Materi Hari Ini',),
                  ],
                ),
                SizedBox(height: 20,),
                TitleBar(judul: "Tugas Terbaru"),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ),
    );
  }

}