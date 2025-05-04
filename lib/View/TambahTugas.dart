import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/CustomDatePicker.dart';
import 'package:sina_mobile/View/Component/CustomFilePicker.dart';
import 'package:sina_mobile/View/Component/CustomTextArea.dart';
import 'package:sina_mobile/View/Component/CustomTextField.dart';
import 'package:sina_mobile/View/Component/RegularButton.dart';
import 'package:sina_mobile/View/Component/TitleBarLine.dart';

class TambahTugas extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleBarLine(judul: "Tambah Tugas"),
              SizedBox(height: 40,),
              Text("Judul", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              CustomTextField(controller: TextEditingController(), hintText: "Masukan Judul",),
              SizedBox(height: 20,),
              Text("Deskripsi", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              CustomTextArea(controller: TextEditingController(), hintText: "Masukan Deskripsi",),
              SizedBox(height: 20,),
              Text("File", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              CustomFilePicker(
                label: 'Upload File',
                onFilePicked: (filePath) {
                  print('File dipilih: $filePath');
                },
              ),
              SizedBox(height: 20),
              Text("Tenggat", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              CustomDatePicker(
                controller: TextEditingController(),
                hintText: 'Pilih Tenggat',
              ),
            ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: RegularButton(onTap: (){}, judul: "Tambahkan"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );
  }

}