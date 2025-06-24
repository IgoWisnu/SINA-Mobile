import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/Box.dart';
import 'package:sina_mobile/View/Component/ClassCard.dart';
import 'package:sina_mobile/View/Component/CustomAppBar.dart';
import 'package:sina_mobile/View/Component/ItemRapotSiswa.dart';
import 'package:sina_mobile/View/Component/ItemTugas.dart';
import 'package:sina_mobile/View/Component/Murid/CustomMuridDrawer.dart';
import 'package:sina_mobile/View/Component/Murid/ItemRapotMurid.dart';
import 'package:sina_mobile/View/Component/TitleBar.dart';
import 'package:sina_mobile/View/Murid/RapotDetailMurid.dart';
import 'package:sina_mobile/ViewModel/RaporSiswaViewModel.dart';
import 'package:provider/provider.dart';

class RapotMurid extends StatefulWidget {
  RapotMurid({super.key});

  @override
  State<RapotMurid> createState() => _RapotMuridState();


}

class _RapotMuridState extends State<RapotMurid> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String currentMenu = 'rapot';

  @override
  void initState() {
    super.initState();
    // Ambil data kelas saat widget dibuka
    Future.microtask(() =>
        Provider.of<RaporSiswaViewModel>(context, listen: false).getlistRapor()
    );
  }


  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<RaporSiswaViewModel>(context);


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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: vm.isLoading
              ? Center(child: CircularProgressIndicator())
              : vm.error != null
              ? Center(child: Text('Error: ${vm.error}'))
              : ItemRapotMurid(
                kelas: vm.detailkelas?.tingkat ?? '',
                ontap : (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RapotDetailMurid(
                      idAkademik: vm.detailkelas?.tahunAkademik.id ?? '2024',
                    )),
                  );
                }

          )
          ),
        ),
    );
  }
}