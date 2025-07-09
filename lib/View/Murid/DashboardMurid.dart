import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sina_mobile/ViewModel/DashboardViewModel.dart';
import 'package:sina_mobile/View/Component/Box.dart';
import 'package:sina_mobile/View/Component/ClassCard.dart';
import 'package:sina_mobile/View/Component/CustomAppBar.dart';
import 'package:sina_mobile/View/Component/Murid/CustomMuridDrawer.dart';
import 'package:sina_mobile/View/Component/Murid/ItemTugasMurid.dart';
import 'package:sina_mobile/View/Component/TitleBar.dart';

class DashboardMurid extends StatefulWidget {
  const DashboardMurid({super.key});

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
      key: _scaffoldKey,
      drawer: CustomMuridDrawer(selectedMenu: currentMenu),
      appBar: CustomAppBar(
        onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
      ),
      body: status == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ringkasan
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Box(
                  jumlah: status.ringkasan.tugasBelumDikerjakan,
                  keterangan: 'Tugas Belum Dikerjakan',
                ),
                const SizedBox(width: 10),
                Box(
                  jumlah: status.ringkasan.absensiTidakHadir,
                  keterangan: 'Absensi Tidak Hadir',
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Box(
                  jumlah: status.ringkasan.tugasTerlambat,
                  keterangan: 'Tugas Terlambat',
                ),
                const SizedBox(width: 10),
                Box(
                  jumlah: status.ringkasan.materiHariIni,
                  keterangan: 'Materi Hari Ini',
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Tugas Terbaru
            const TitleBar(judul: "Tugas Terbaru"),
            const SizedBox(height: 10),
            ...status.tugasTerbaru.map((tugas) {
              return ItemTugasMurid(
                tugas: tugas,
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(
                  //   builder: (context) => DetailTugasMurid(tugas: tugas),
                  // ));
                },
              );
            }).toList(),

            const SizedBox(height: 20),

            // Kelas Hari Ini
            const TitleBar(judul: "Kelas Hari Ini"),
            const SizedBox(height: 10),
            ...status.kelasHariIni.map((kelas) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ClassCard(
                  judul: kelas.namaMapel,
                  onTap: () {},
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
