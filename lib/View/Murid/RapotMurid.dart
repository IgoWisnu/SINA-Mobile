import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/Box.dart';
import 'package:sina_mobile/View/Component/ClassCard.dart';
import 'package:sina_mobile/View/Component/CustomAppBar.dart';
import 'package:sina_mobile/View/Component/ItemTugas.dart';
import 'package:sina_mobile/View/Component/Murid/CustomMuridDrawer.dart';
import 'package:sina_mobile/View/Component/Murid/ItemRapotMurid.dart';
import 'package:sina_mobile/View/Component/TitleBar.dart';

class RapotMurid extends StatefulWidget {
  RapotMurid({super.key});

  @override
  State<RapotMurid> createState() => _RapotMuridState();


}

class _RapotMuridState extends State<RapotMurid> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String currentMenu = 'rapot';

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              TitleBar(judul: "List Rapot Siswa"),
              ItemRapotMurid(),
              ItemRapotMurid(),
              ItemRapotMurid(),
            ],
          ),
        ),
      ),
    );
  }
}