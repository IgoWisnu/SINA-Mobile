import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/CardPengumuman.dart';

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
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
             children: [
               CardPengumuman(
                 Action: (){

                 },
               ),
               CardPengumuman(
                 Action: (){

                 },
               ),
             ],
          ),
        ),
      ),
    );
  }
}