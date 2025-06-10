import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/Berita.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:html/parser.dart';
import 'package:sina_mobile/View/Component/RegularButton.dart';
import 'package:sina_mobile/View/EditPengumuman.dart';
import 'package:sina_mobile/View/Lib/DateFormatter.dart'; // Untuk parse HTML

class PengumumanDetailGuru extends StatefulWidget{
  final Berita berita;

  const PengumumanDetailGuru({super.key, required this.berita});

  @override
  State<PengumumanDetailGuru> createState() => _PengumumanDetailGuruState();
}

class _PengumumanDetailGuruState extends State<PengumumanDetailGuru> {
  String baseImageUrl = 'http://sina.pnb.ac.id:3000/Upload/berita/';

  /// Membersihkan HTML dan memotong isi hingga `limit` karakter
  String stripHtmlAndLimit(String htmlText, int limit) {
    final document = parse(htmlText);
    final String parsedString = parse(document.body?.text).documentElement?.text ?? '';
    if (parsedString.length <= limit) {
      return parsedString;
    } else {
      return parsedString.substring(0, limit) + '...';
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Ink.image(
                    image: NetworkImage('$baseImageUrl${widget.berita.foto}'),
                    height: 250,
                    fit: BoxFit.fill,)
              ),
              SizedBox(height: 30,),
              Text(widget.berita.judul, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text(stripHtmlAndLimit(widget.berita.isi, 1000)),
              SizedBox(height: 10,),
              Container(
                alignment: Alignment.topRight,
                child: Text(DateFormatter.format(widget.berita.createdAt), style: TextStyle(color: Colors.grey),),
              ),
              SizedBox(height: 20,),
              Column(
                children: [
                  RegularButton(onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditPengumuman(berita: this.berita),
                        ),
                    );
                  }, judul: 'Edit Berita'),
                  SizedBox(height: 10,),
                  RegularButton(onTap: (){

                  }, judul: 'Hapus Berta', color: Colors.red,)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}