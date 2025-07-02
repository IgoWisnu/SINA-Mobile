import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/CustomAppBar.dart';
import 'package:sina_mobile/View/Component/CustomDropdown.dart';
import 'package:sina_mobile/View/Component/Custom_drawer.dart';
import 'package:sina_mobile/View/Component/ItemStatistikSiswa.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';
import 'package:sina_mobile/View/Murid/StatistikSiswa.dart';
import 'package:sina_mobile/View/StatistikGuruDetail.dart';

class ListStatistikGuru extends StatefulWidget{

  @override
  State<ListStatistikGuru> createState() => _ListStatistikGuruState();
}

class _ListStatistikGuruState extends State<ListStatistikGuru> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String currentMenu = 'statistik';
  String selectedValue = 'X.1';

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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("Statistik Nilai Siswa", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                CustomDropdown(
                  items: ['X.1','X.2','X.3',],
                  selectedItem: selectedValue,
                  onChanged: (newValue) {
                    setState(() {
                      selectedValue = newValue!;
                    });
                  },
                )
              ],
            ),
            SizedBox(height: 20,),
            Container(
             height: 50,
             width: double.infinity,
             decoration: BoxDecoration(
               color: AppColors.primary
             ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("No", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
                    Text("Nama", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    Text("Detail", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))
                  ],
                ),
              ),
            ),
            ItemStatistikSiswa(
                no: "1",
                nama: "I Gede Igo",
                ontap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => StatistikGuruDetail()),
                  );
                }
            )
          ],
        ),
      ),

    );
  }
}