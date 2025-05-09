import 'package:flutter/material.dart';

import '../CustomFilePicker.dart';
import '../CustomTextArea.dart';
import '../RegularButton.dart';

class KumpulkanTugasMurid extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Kumpulkan Tugas"),
        SizedBox(height: 5,),
        CustomFilePicker(label: "Upload Tugas", onFilePicked: (filePath) {
          print('File dipilih: $filePath');
        }),
        SizedBox(height: 10,),
        CustomTextArea(controller: TextEditingController(), hintText: "Tambahkan deskripsi...",),
        SizedBox(height: 10,),
        RegularButton(onTap: (){}, judul: "Kumpulkan")
      ],
    );
  }

}