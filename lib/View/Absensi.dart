import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/CustomAppBar.dart';
import 'package:sina_mobile/View/Component/CustomDropdown.dart';
import 'package:sina_mobile/View/Component/Custom_drawer.dart';
import 'package:sina_mobile/View/Component/ItemAbsensi.dart';
import 'package:sina_mobile/View/Component/RegularButton.dart';
import 'package:sina_mobile/View/Component/TitleAbsensi.dart';
import 'package:sina_mobile/View/Component/TitleBar.dart';

class Absensi extends StatefulWidget{
  @override
  State<Absensi> createState() => _AbsensiState();
}

class _AbsensiState extends State<Absensi> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String currentMenu = 'absensi';
  String selectedValue = 'Option 1';

  @override
  Widget build(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomDropdown(
                    items: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
                    selectedItem: selectedValue,
                    onChanged: (newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },
                  ),
                  Container(
                    width: 120,
                    height: 32,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.date_range_outlined),
                          Text("14 Jan 2025")
                        ],
                      ),
                    )
                  )
                ],
              ),
              SizedBox(height: 10,),
              TitleAbsensi(),
              ItemAbsensi(),
              ItemAbsensi(),
              ItemAbsensi(),
              ItemAbsensi(),
              ItemAbsensi(),
              ItemAbsensi(),
              ItemAbsensi(),
              ItemAbsensi(),
              ItemAbsensi(),
              SizedBox(height: 50,),
              RegularButton(onTap: (){} , judul: "Simpan")
            ],
          ),
        ),
      ),
    );
  }
}