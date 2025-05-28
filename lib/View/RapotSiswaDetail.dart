import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/CustomTextField.dart';
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

  final namaController = TextEditingController();
  final mataPelajaranController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Data demo (dummy)
    namaController.text = "I Gede Igo Wisnu Wardana";
    mataPelajaranController.text = "Matematika";
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleBarLine(judul: "Input Nilai Rapot"),
            SizedBox(height: 20,),
            Text('Nama Siswa', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            SizedBox(height: 5,),
            CustomTextField(controller: namaController),
            SizedBox(height: 20,),
            Text('Mata Pelajaran', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            SizedBox(height: 5,),
            CustomTextField(controller: mataPelajaranController),
            SizedBox(height: 20,),
            Text('Nilai', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            SizedBox(height: 5,),
            CustomTextField(controller: TextEditingController()),
            SizedBox(height: 30,),
            RegularButton(onTap: (){}, judul: "Draf"),
            SizedBox(height: 10,),
            RegularButton(onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ListRapotSiswa()));
            }, judul: "Simpan")

          ],
        ),
      ),
    );
  }
}