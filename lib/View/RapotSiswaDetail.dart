import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/ItemNilaiRapot.dart';
import 'package:sina_mobile/View/Component/RegularButton.dart';
import 'package:sina_mobile/View/Component/TitleBarLine.dart';
import 'package:sina_mobile/View/ListRapotSiswa.dart';

import 'Lib/Colors.dart';

class RapotSiswaDetail extends StatefulWidget{

  @override
  State<RapotSiswaDetail> createState() => _RapotSiswaDetailState();
}

class _RapotSiswaDetailState extends State<RapotSiswaDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TitleBarLine(judul: "Detail Rapot"),
            SizedBox(height: 20,),
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
                    Text("Mata Pelajaran", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    Text("Nilai", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            ),
            ItemNilaiRapot(controller: TextEditingController(), mata_pelajaran: "Matematika", no: "1"),
            ItemNilaiRapot(controller: TextEditingController(), mata_pelajaran: "Matematika", no: "2"),
            ItemNilaiRapot(controller: TextEditingController(), mata_pelajaran: "Javascript", no: "3"),
            ItemNilaiRapot(controller: TextEditingController(), mata_pelajaran: "CSS", no: "4"),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: RegularButton(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ListRapotSiswa()));
            }
            , judul: "Simpan"),
      ),
    );
  }
}