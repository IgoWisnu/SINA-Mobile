import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/AddButton.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/DetailTugas.dart';
import 'package:sina_mobile/View/Component/ItemTugasSiswa.dart';
import 'package:sina_mobile/View/Component/StatusTugas.dart';
import 'package:sina_mobile/View/Component/TitleBarLine.dart';

class MateriDetailGuru extends StatefulWidget{
  final String judul;
  final String deskripsi;
  final String lampiran;

  const MateriDetailGuru({
    super.key,
    required this.judul,
    required this.deskripsi,
    required this.lampiran
  });

  @override
  State<MateriDetailGuru> createState() => _MateriDetailGuruState();
}

class _MateriDetailGuruState extends State<MateriDetailGuru> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TitleBarLine(judul: widget.judul),
              SizedBox(height: 20,),
              DetailTugas(
                judul: widget.judul,
                keterangan: widget.deskripsi
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),

      ),
    );
  }
}