import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/CardPengumuman.dart';
import 'package:sina_mobile/View/Component/OrangTua/CardPengumumanOrtu.dart';
import 'package:sina_mobile/View/Component/OrangTua/CustomOrangTuaDrawer.dart';
import 'package:provider/provider.dart';
import 'package:sina_mobile/View/OrangTua/PengumumanDetailOrangTua.dart';
import 'package:sina_mobile/ViewModel/OrangTua/BeritaOrangTuaViewModel.dart';

import '../Component/CustomAppBar.dart';

class PengumumanOrtu extends StatefulWidget {
  @override
  State<PengumumanOrtu> createState() => _PengumumanOrtuState();
}

class _PengumumanOrtuState extends State<PengumumanOrtu> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String currentMenu = 'pengumumanOrtu';

  @override
  void initState() {
    super.initState();
    // Ambil data kelas saat widget dibuka
    Future.microtask(
      () =>
          Provider.of<BeritaOrangTuaViewModel>(
            context,
            listen: false,
          ).fetchBeritaOrangTua(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<BeritaOrangTuaViewModel>(context);

    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey, // ← INI YANG BELUM ADA
      drawer: CustomOrangTuaDrawer(selectedMenu: currentMenu),
      appBar: CustomAppBar(
        onMenuPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      body:
          vm.isLoading
              ? Center(child: CircularProgressIndicator())
              : vm.error != null
              ? Center(child: Text('Error: ${vm.error}'))
              : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  itemCount: vm.beritaListOrangTua.length,
                  itemBuilder: (context, index) {
                    final beritaItem = vm.beritaListOrangTua[index];
                    return CardPengumumanOrtu(
                      berita: beritaItem,
                      Action: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => PengumumanDetailOrangTua(
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
