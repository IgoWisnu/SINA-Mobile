import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/Berita.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';

class PengumumanDetailMurid extends StatefulWidget{
  final Berita berita;

  const PengumumanDetailMurid({super.key, required this.berita});

  @override
  State<PengumumanDetailMurid> createState() => _PengumumanDetailMuridState();
}

class _PengumumanDetailMuridState extends State<PengumumanDetailMurid> {
  String baseImageUrl = 'http://sina.pnb.ac.id:3000/Upload/berita/';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
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
              SizedBox(height: 10,),
              Text(widget.berita.judul, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text(widget.berita.isi),
              SizedBox(height: 10,),
              Container(
                alignment: Alignment.topRight,
                child: Text(widget.berita.createdAt.toString(), style: TextStyle(color: Colors.grey),),
              )
            ],
          ),
        ),
      ),
    );
  }
}