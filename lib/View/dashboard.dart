import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/Box.dart';
import 'package:sina_mobile/View/Component/ClassCard.dart';
import 'package:sina_mobile/View/Component/CustomAppBar.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/Custom_drawer.dart';
import 'package:sina_mobile/View/Component/ItemAbsensi.dart';
import 'package:sina_mobile/View/Component/ItemTugas.dart';
import 'package:sina_mobile/View/Component/Murid/ItemTugasMurid.dart';
import 'package:sina_mobile/View/Component/TitleAbsensi.dart';
import 'package:sina_mobile/View/Component/TitleBar.dart';
import 'package:sina_mobile/View/TugasDetail.dart';

class dashboard extends StatefulWidget {
  dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();


}

class _dashboardState extends State<dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String currentMenu = 'dashboard';

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Box(jumlah: 5, keterangan: 'Siswa tidak hadir',),
                  const SizedBox(width: 10),
                  Box(jumlah: 24, keterangan: 'Siswa Hadir',),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Box(jumlah: 6, keterangan: 'Belum mengumpulkan',),
                  const SizedBox(width: 10),
                  Box(jumlah: 2, keterangan: 'Tugas tuntas',),
                ],
              ),
              SizedBox(height: 20,),
              TitleBar(judul: "Tugas Terbaru"),
              ItemTugasMurid(
                  judul: "Tugas Javascript 3",
                  upload_date: DateTime(2024, 5, 20),
                  tenggat: DateTime(2024, 5, 23),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TugasDetail()),
                    );
                  }
              ),
              ItemTugasMurid(
                  judul: "Tugas Javascript 2",
                  upload_date: DateTime(2025, 5, 2),
                  tenggat: DateTime(2025, 5, 15),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TugasDetail()),
                    );
                  }
              ),
              ItemTugasMurid(
                  judul: "Tugas Javascript 1",
                  upload_date: DateTime(2025, 4, 29),
                  tenggat: DateTime(2025, 5, 2),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TugasDetail()),
                    );
                  }
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }

}