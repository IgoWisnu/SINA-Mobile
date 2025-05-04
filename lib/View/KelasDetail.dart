import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/AddButton.dart';
import 'package:sina_mobile/View/Component/ClassCard.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/ItemTugas.dart';
import 'package:sina_mobile/View/Component/StatusTugas.dart';
import 'package:sina_mobile/View/Component/TitleBarLine.dart';
import 'package:sina_mobile/View/TambahTugas.dart';

class KelasDetail extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            ClassCard(judul: "Javascript/XI.3", onTap: (){}),
            SizedBox(height: 20,),
            TitleBarLine(judul: "Kelas XI.3"),
            ItemTugas(),
            ItemTugas(),
            ItemTugas(),

          ],
        ),
      ),
        floatingActionButton: AddButton(
        onPressed: (){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TambahTugas()),
      );
    },
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

}