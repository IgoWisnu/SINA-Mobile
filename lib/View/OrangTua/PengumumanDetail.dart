import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';

class PengumumanDetail extends StatelessWidget{

  final String judul;
  final String deskripsi;
  final upload_at;

  const PengumumanDetail({super.key, required this.judul, required this.deskripsi, required this.upload_at});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              child: Image.asset("lib/asset/iamge/pengumuman.png"),
            ),
            SizedBox(height: 20,),
            Text("", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Text(""),
            SizedBox(height: 20,),
            Text("")
          ],
        ),
      ),
    );
  }

}