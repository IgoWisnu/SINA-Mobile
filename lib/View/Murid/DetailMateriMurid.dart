import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:provider/provider.dart';
import 'package:sina_mobile/Model/Materi.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/DetailTugas.dart';
import 'package:sina_mobile/View/Component/RegularButton.dart';
import 'package:sina_mobile/ViewModel/DetailMateriViewModel.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:pdfx/pdfx.dart';
import 'package:open_file/open_file.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';

class DetailMateriMurid extends StatelessWidget {
  final Materi materi;

  const DetailMateriMurid({super.key, required this.materi});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetailMateriMuridViewModel(),
      child: _DetailMateriMuridBody(materi: materi),
    );
  }
}

class _DetailMateriMuridBody extends StatefulWidget {
  final Materi materi;

  const _DetailMateriMuridBody({required this.materi});

  @override
  State<_DetailMateriMuridBody> createState() => _DetailMateriMuridBodyState();
}

class _DetailMateriMuridBodyState extends State<_DetailMateriMuridBody> {
  late Future<File> _pdfFile;
  File? _downloadedFile;

  @override
  void initState() {
    super.initState();
    final url = 'http://sina.pnb.ac.id:3007/Upload/tugas/${widget.materi.lampiran}';
    final fileName = widget.materi.lampiran ?? 'file.pdf';

    _pdfFile = downloadPdfFileLocal(url, fileName)..then((file) {
      setState(() {
        _downloadedFile = file;
      });
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
        const SnackBar(content: Text("File belum tersedia")),
      );
      return;
    }

    OpenFile.open(_downloadedFile!.path);
  }

  @override
  Widget build(BuildContext context) {
    final pdfUrl = "http://sina.pnb.ac.id:3007/Upload/tugas/${widget.materi.lampiran}";

    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              DetailTugas(
                judul: widget.materi.namaMateri,
                keterangan: widget.materi.deskripsi,
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 500,
                child: (pdfUrl.isEmpty)
                    ? const Center(child: Text("Tidak ada file tersedia"))
                    : FutureBuilder<File>(
                  future: _pdfFile,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Gagal memuat file PDF'));
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
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: openWithExternalApp,
                icon: const Icon(Icons.open_in_new),
                label: const Text("Buka dengan aplikasi lain"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}