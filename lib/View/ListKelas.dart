import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/AddButton.dart';
import 'package:sina_mobile/View/Component/ClassCard.dart';
import 'package:sina_mobile/View/Component/CustomAppBar.dart';
import 'package:sina_mobile/View/Component/Custom_drawer.dart';
import 'package:sina_mobile/View/KelasDetail.dart';
import 'package:sina_mobile/View/TambahTugas.dart';
import 'package:sina_mobile/ViewModel/Guru/KelasGuruViewModel.dart';
import 'package:provider/provider.dart';

class ListKelas extends StatefulWidget{
  @override
  State<ListKelas> createState() => _ListKelasState();
}

class _ListKelasState extends State<ListKelas> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // Ambil data kelas saat widget dibuka
    Future.microtask(() =>
        Provider.of<KelasGuruViewModel>(context, listen: false).fetchKelas());
  }

  String currentMenu = 'kelas';

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<KelasGuruViewModel>(context);

    // TODO: implement build
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: vm.isLoading
            ? Center(child: CircularProgressIndicator())
            : vm.error != null
            ? Center(child: Text('Error: ${vm.error}'))
            : ListView.builder(
          itemCount: vm.kelasList.length,
          itemBuilder: (context, index) {
            final kelas = vm.kelasList[index];
            return ClassCard(
              judul: kelas.namaMapel,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KelasDetail(
                      mapelId: kelas.mapelId,
                      mapelJudul: kelas.namaMapel,
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