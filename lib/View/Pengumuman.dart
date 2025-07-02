import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/Berita.dart';
import 'package:sina_mobile/View/Component/AddButton.dart';
import 'package:sina_mobile/View/Component/CardPengumuman.dart';
import 'package:sina_mobile/View/Murid/PengumumanDetail.dart';
import 'package:sina_mobile/View/Murid/PengumumanDetailMurid.dart';
import 'package:sina_mobile/View/PengumumanDetailGuru.dart';
import 'package:sina_mobile/View/TambahPengumuman.dart';
import 'package:sina_mobile/ViewModel/Guru/PengumumanGuruViewModel.dart';
import 'package:provider/provider.dart';
import 'Component/CustomAppBar.dart';
import 'Component/Custom_drawer.dart';

class Pengumuman extends StatefulWidget{

  @override
  State<Pengumuman> createState() => _PengumumanState();
}

class _PengumumanState extends State<Pengumuman> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String currentMenu = 'pengumuman';

  @override
  void initState() {
    super.initState();
    // Ambil data kelas saat widget dibuka
    Future.microtask(() =>
        Provider.of<PengumumanGuruViewModel>(context, listen: false).fetchBerita());
  }


  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PengumumanGuruViewModel>(context);

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
      body: vm.isLoading
          ? Center(child: CircularProgressIndicator())
          : vm.error != null
          ? Center(child: Text('Error: ${vm.error}'))
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          itemCount: vm.beritaList.length,
          itemBuilder: (context, index) {
            final beritaItem = vm.beritaList[index];
            return CardPengumuman(
              berita: beritaItem,
              Action: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PengumumanDetailGuru(
                      berita: beritaItem,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: AddButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TambahPengumuman(),
            ),
          );
          vm.fetchBerita();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}