import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sina_mobile/View/Component/ClassCard.dart';
import 'package:sina_mobile/View/Component/CustomAppBar.dart';
import 'package:sina_mobile/View/Component/Murid/ClassCardMurid.dart';
import 'package:sina_mobile/View/Component/Murid/CustomMuridDrawer.dart';
import 'package:sina_mobile/View/Murid/DetailKelasMurid.dart';
import 'package:sina_mobile/ViewModel/KelasViewModel.dart';

class ListKelasMurid extends StatefulWidget {
  @override
  State<ListKelasMurid> createState() => _ListKelasMuridState();
}

class _ListKelasMuridState extends State<ListKelasMurid> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String currentMenu = 'kelas';

  @override
  void initState() {
    super.initState();
    // Ambil data kelas saat widget dibuka
    Future.microtask(() =>
        Provider.of<KelasViewModel>(context, listen: false).fetchKelas());
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<KelasViewModel>(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomMuridDrawer(selectedMenu: currentMenu),
      appBar: CustomAppBar(
        onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
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
            return ClassCardMurid(
              judul: '${kelas.namaMapel} / ${kelas.namaKelas}',
              namaGuru: kelas.namaGuru,
              image: kelas.fotoProfil ?? '',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailKelasMurid(
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
