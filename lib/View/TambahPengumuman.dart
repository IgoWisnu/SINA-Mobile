import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/CustomFilePicker.dart';
import 'package:sina_mobile/View/Component/CustomTextField.dart';
import 'package:sina_mobile/View/Component/RegularButton.dart';
import 'package:sina_mobile/View/Component/TitleBarLine.dart';

import 'Component/CustomTextArea.dart';

class TambahPengumuman extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TitleBarLine(judul: "Tambah Pengumuman"),
            SizedBox(height: 20,),
            Text("Judul", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
            SizedBox(height: 5,),
            CustomTextField(controller: TextEditingController(), hintText: "Masukan judul",),
            SizedBox(height: 5,),
            Text("Deskripsi", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
            SizedBox(height: 5,),
            CustomTextArea(controller: TextEditingController(), hintText: "Masukan Deskripsi",),
            SizedBox(height: 5,),
            CustomFilePicker(label: "Upload Gambar", onFilePicked: (filePath) {
              print('File dipilih: $filePath');
            },),
            SizedBox(height: 20,),
            RegularButton(onTap: (){}, judul: "Simpan"),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }

}