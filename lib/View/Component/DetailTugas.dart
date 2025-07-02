import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';

class DetailTugas extends StatelessWidget{
  final judul;
  final keterangan;

  const DetailTugas({super.key, required this.judul, required this.keterangan});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(judul, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
            SizedBox(height: 5),
            Text(keterangan),
            SizedBox(height: 20),
            Text("File Preiview"),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset('lib/asset/image/SINA.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }

}