import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/Berita.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:html/parser.dart';
import 'package:sina_mobile/View/Component/CustomSnackbar.dart';
import 'package:sina_mobile/View/Component/RegularButton.dart';
import 'package:sina_mobile/View/EditPengumuman.dart';
import 'package:sina_mobile/View/Lib/DateFormatter.dart'; // Untuk parse HTML
import 'package:provider/provider.dart';
import 'package:sina_mobile/ViewModel/Guru/PengumumanGuruViewModel.dart';
import 'package:sina_mobile/service/api/ApiServiceGuru.dart';
import 'package:sina_mobile/service/repository/Guru/BeritaGuruRepository.dart';

class PengumumanDetailGuru extends StatefulWidget{
  final Berita berita;

  const PengumumanDetailGuru({super.key, required this.berita});

  @override
  State<PengumumanDetailGuru> createState() => _PengumumanDetailGuruState();
}

class _PengumumanDetailGuruState extends State<PengumumanDetailGuru> {
  String baseImageUrl = 'http://sina.pnb.ac.id:3000/Upload/berita/';
  final PengumumanGuruViewModel _viewModel = PengumumanGuruViewModel(repository: BeritaGuruRepository(ApiServiceGuru()));

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

  void _deletePengumuman() async {
    try {
      await _viewModel.deleteBerita(
        idBerita: widget.berita.beritaId
      );

      CustomSnackbar.showSuccess(context, "Berhasil Menghapus Berita");
      Navigator.pop(context, true); // mengirim flag "data berubah"
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal Menghapus Berita: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PengumumanGuruViewModel>(context, listen: false);

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
                  RegularButton(onTap: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditPengumuman(berita: widget.berita),
                        ),
                    );
                  }, judul: 'Edit Berita'),
                  SizedBox(height: 10,),
                  RegularButton(onTap: (){
                    _deletePengumuman();
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