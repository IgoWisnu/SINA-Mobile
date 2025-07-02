import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/CustomAppBar.dart';
import 'package:sina_mobile/View/Component/Custom_drawer.dart';
import 'package:sina_mobile/View/Component/ItemDaftarIzin.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';
import 'package:sina_mobile/View/VerifikasiSuratIzinDetail.dart';

class VerifikasiSuratIzin extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    String currentMenu = 'surat_izin';

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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text("Daftar Izin", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                ),
                alignment: Alignment.centerLeft,
              ),
              ItemDaftarIzin(nama: "Igo Wisnu", kelas: "XI.5", tanggal: "25/5/2025",
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VerifikasiSuratIzinDetail()
                      ),
                    );
                  }
              )
            ],

          ),
        ),
      ),
    );
  }

}
