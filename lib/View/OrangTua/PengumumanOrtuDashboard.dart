import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sina_mobile/Model/OrangTua/BeritaOrangTua.dart';
import 'package:sina_mobile/View/Component/OrangTua/CardPengumumanOrtu.dart';
import 'package:sina_mobile/View/OrangTua/PengumumanDetailOrangTua.dart';
import 'package:sina_mobile/ViewModel/OrangTua/BeritaOrangTuaViewModel.dart';

class PengumumanOrtuDashboard extends StatefulWidget {
  @override
  State<PengumumanOrtuDashboard> createState() =>
      _PengumumanOrtuDashboardState();
}

class _PengumumanOrtuDashboardState extends State<PengumumanOrtuDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

    return vm.isLoading
        ? const Center(child: CircularProgressIndicator())
        : vm.error != null
        ? Center(child: Text('Error: ${vm.error}'))
        : ListView.builder(
          shrinkWrap: true,
          physics:
              NeverScrollableScrollPhysics(), // ← penting untuk nested scroll
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
                        (context) =>
                            PengumumanDetailOrangTua(berita: beritaItem),
                  ),
                );
              },
            );
          },
        );
  }
}
