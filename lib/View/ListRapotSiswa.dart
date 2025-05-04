import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/CustomDropdown.dart';
import 'package:sina_mobile/View/Component/ItemRapotSiswa.dart';

import 'Component/CustomAppBar.dart';
import 'Component/Custom_drawer.dart';
import 'Lib/Colors.dart';

class ListRapotSiswa extends StatefulWidget{
  const ListRapotSiswa({super.key});

  @override
  State<ListRapotSiswa> createState() => _ListRapotSiswaState();
}

class _ListRapotSiswaState extends State<ListRapotSiswa> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String currentMenu = 'rapot';
  String selectedItem = "XI.1";

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("List Rapot Siswa", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                CustomDropdown(
                  items: ['XI.1', 'XI.2', 'XI.5', 'XI.7', 'XI.8'],
                  selectedItem: selectedItem,
                  onChanged: (newValue) {
                    setState(() {
                      selectedItem = newValue!;
                    });
                  },
                )
              ],
            ),
            SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primary,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("No", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    Text("Siswa", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    Text("Status Rapot", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),

            ),
            ItemRapotSiswa(no: '1', nama: 'I Gede Igo Wisnu W',),
            ItemRapotSiswa(no: '2', nama: 'Banana Bin Dev',),
            ItemRapotSiswa(no: '3', nama: 'Max Verstapen',),
            ItemRapotSiswa(no: '4', nama: 'Lando Noris',),
            ItemRapotSiswa(no: '5', nama: 'Oscar Piastri',),

          ],
        ),
      ),
    );
  }
}