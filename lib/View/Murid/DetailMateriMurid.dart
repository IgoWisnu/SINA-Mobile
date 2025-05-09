import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/AddButton.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/CustomFilePicker.dart';
import 'package:sina_mobile/View/Component/CustomTextArea.dart';
import 'package:sina_mobile/View/Component/DetailTugas.dart';
import 'package:sina_mobile/View/Component/ItemTugasSiswa.dart';
import 'package:sina_mobile/View/Component/RegularButton.dart';
import 'package:sina_mobile/View/Component/StatusTugas.dart';
import 'package:sina_mobile/View/Component/TitleBarLine.dart';

class DetailMateriMurid extends StatefulWidget{

  @override
  State<DetailMateriMurid> createState() => _DetailMateriMuridState();
}

class _DetailMateriMuridState extends State<DetailMateriMurid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StatusTugas(),
              SizedBox(height: 20,),
              DetailTugas(),
              SizedBox(height: 20,),
            ],
          ),
        ),

      ),
    );
  }
}