import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/AddButton.dart';
import 'package:sina_mobile/View/Component/ClassCard.dart';
import 'package:sina_mobile/View/Component/CustomAppBar.dart';
import 'package:sina_mobile/View/Component/Custom_drawer.dart';
import 'package:sina_mobile/View/Component/Murid/CustomMuridDrawer.dart';
import 'package:sina_mobile/View/KelasDetail.dart';
import 'package:sina_mobile/View/Murid/DetailKelasMurid.dart';
import 'package:sina_mobile/View/TambahTugas.dart';

class ListKelasMurid extends StatefulWidget{
  @override
  State<ListKelasMurid> createState() => _ListKelasMuridState();
}

class _ListKelasMuridState extends State<ListKelasMurid> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String currentMenu = 'kelas';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            ClassCard(
                judul: "Javascript/XI.3",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailKelasMurid()
                    ),
                  );
                }
            ),
            ClassCard(
                judul: "Javascript/XI.3",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailKelasMurid()
                    ),
                  );
                }
            ),
            ClassCard(
                judul: "Javascript/XI.3",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailKelasMurid()
                    ),
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}