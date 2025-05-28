import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/AddButton.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/DetailTugas.dart';
import 'package:sina_mobile/View/Component/ItemTugasSiswa.dart';
import 'package:sina_mobile/View/Component/StatusTugas.dart';
import 'package:sina_mobile/View/Component/TitleBarLine.dart';

class MateriDetail extends StatefulWidget{

  @override
  State<MateriDetail> createState() => _MateriDetailState();
}

class _MateriDetailState extends State<MateriDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TitleBarLine(judul: "Apa itu javascript?"),
              SizedBox(height: 20,),
              DetailTugas(
                judul: 'Javascript',
                keterangan: 'JavaScript adalah bahasa pemrograman yang digunakan untuk membuat halaman web menjadi interaktif dan dinamis. Bahasa ini berjalan di sisi klien (client-side) pada browser, meskipun juga dapat digunakan di sisi server (server-side) dengan platform seperti Node.js.',
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),

      ),
    );
  }
}