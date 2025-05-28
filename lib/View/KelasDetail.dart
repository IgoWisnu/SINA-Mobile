import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/AddButton.dart';
import 'package:sina_mobile/View/Component/ClassCard.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/ItemMateriGuru.dart';
import 'package:sina_mobile/View/Component/ItemTugas.dart';
import 'package:sina_mobile/View/Component/Murid/ItemTugasMurid.dart';
import 'package:sina_mobile/View/Component/StatusTugas.dart';
import 'package:sina_mobile/View/Component/TitleBarLine.dart';
import 'package:sina_mobile/View/MateriDetailGuru.dart';
import 'package:sina_mobile/View/TambahTugas.dart';
import 'package:sina_mobile/View/TugasDetail.dart';

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
            ItemTugasMurid(
                judul: "Tugas Javascript 1",
                upload_date: DateTime(2024, 5, 20),
                tenggat: DateTime(2024, 5, 23),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TugasDetail()),
                  );
                }
            ),
            ItemMateriGuru(judul: "Dasar Javascript", upload_date: DateTime(2024, 5, 20),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MateriDetail()),
                  );
                }
            ),
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