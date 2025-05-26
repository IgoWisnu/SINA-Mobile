import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/CardPengumuman.dart';
import 'package:sina_mobile/View/Component/Murid/CustomMuridDrawer.dart';
import 'package:sina_mobile/View/Murid/PengumumanDetailMurid.dart';
import 'package:provider/provider.dart';
import 'package:sina_mobile/ViewModel/BeritaViewModel.dart';

import '../Component/CustomAppBar.dart';
import '../Component/Custom_drawer.dart';

class PengumumanMurid extends StatefulWidget{

  @override
  State<PengumumanMurid> createState() => _PengumumanMuridState();
}

class _PengumumanMuridState extends State<PengumumanMurid> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String currentMenu = 'pengumuman';

  @override
  void initState() {
    super.initState();
    // Ambil data kelas saat widget dibuka
    Future.microtask(() =>
        Provider.of<BeritaViewModel>(context, listen: false).fetchBerita());
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<BeritaViewModel>(context);

    // TODO: implement build
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
                    builder: (context) => PengumumanDetailMurid(
                      berita: beritaItem,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}