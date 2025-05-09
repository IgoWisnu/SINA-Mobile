import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/CardPengumuman.dart';
import 'package:sina_mobile/View/Component/Murid/CustomMuridDrawer.dart';
import 'package:sina_mobile/View/Murid/PengumumanDetailMurid.dart';

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
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              CardPengumuman(
                Action: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PengumumanDetailMurid()),
                  );
                },
              ),
              CardPengumuman(
                Action: (){
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PengumumanDetailMurid()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}