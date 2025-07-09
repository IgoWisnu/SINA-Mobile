import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/AddButton.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/DetailTugas.dart';
import 'package:sina_mobile/View/Component/ItemTugasSiswa.dart';
import 'package:sina_mobile/View/Component/RegularButton.dart';
import 'package:sina_mobile/View/Component/StatusTugas.dart';
import 'package:sina_mobile/View/Component/TitleBarLine.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:pdfx/pdfx.dart';
import 'package:open_file/open_file.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';

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

  late Future<File> _pdfFile;
  File? _downloadedFile;

  @override
  void initState() {
    super.initState();
    // Ambil data kelas saat widget dibuka
    final url = 'http://sina.pnb.ac.id:3007/Upload/tugas/${widget.lampiran}';
    final fileName = widget.lampiran ?? 'file.pdf';

    _pdfFile = downloadPdfFileLocal(url, fileName)
      ..then((file) {
        _downloadedFile = file; // ✅ Tambahkan ini
      });

    print("Download URL: $url");
  }

  Future<File> downloadPdfFileLocal(String url, String filename) async {
    final response = await http.get(Uri.parse(url));
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

  void openWithExternalApp() {
    if (_downloadedFile == null || !_downloadedFile!.existsSync()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("File belum tersedia")),
      );
      return;
    }

    OpenFile.open(_downloadedFile!.path);
  }

  @override
  Widget build(BuildContext context) {
    final pdfUrl = "http://sina.pnb.ac.id:3007/Upload/tugas/${widget.lampiran}";

    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TitleBarLine(judul: 'materi'),
              SizedBox(height: 20,),
              DetailTugas(
                judul: widget.judul,
                keterangan: widget.deskripsi
              ),
              SizedBox(height: 20,),
              Container(
                height: 500,
                child: (pdfUrl == null || pdfUrl.isEmpty)
                    ? Center(child: Text("Tidak ada file tersedia"))
                    : FutureBuilder<File>(
                  future: _pdfFile,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Gagal memuat file PDF'));
                    } else {
                      final file = snapshot.data!;
                      return PdfViewPinch(
                        controller: PdfControllerPinch(
                          document: PdfDocument.openFile(file.path),
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
              RegularButton(onTap: openWithExternalApp, judul: "Buka Lampiran"),
            ],
          ),
        ),

      ),
    );
  }
}