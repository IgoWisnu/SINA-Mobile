import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:provider/provider.dart';
import 'package:sina_mobile/Model/Materi.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/DetailTugas.dart';
import 'package:sina_mobile/View/Component/RegularButton.dart';
import 'package:sina_mobile/ViewModel/DetailMateriViewModel.dart';

class DetailMateriMurid extends StatelessWidget {
  final Materi materi;

  const DetailMateriMurid({super.key, required this.materi});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetailMateriMuridViewModel(),
      child: _DetailMateriMuridBody(materi: materi,),
    );
  }
}

class _DetailMateriMuridBody extends StatelessWidget {
  final Materi materi;

  const _DetailMateriMuridBody({required this.materi});

  @override
  Widget build(BuildContext context) {
    final url = "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf";
    final vm = Provider.of<DetailMateriMuridViewModel>(context);
    final isPDF = url.toLowerCase().endsWith('.pdf') ?? false;

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
                judul: materi.namaMateri,
                keterangan: materi.deskripsi,
              ),
              const SizedBox(height: 20),

              // Preview file
              if (isPDF && vm.localFilePath != null)
                SizedBox(
                  height: 400,
                  child: PDFView(
                    filePath: vm.localFilePath!,
                  ),
                )
              else if (isPDF)
                Container(
                  height: 100,
                  alignment: Alignment.center,
                  child: const Text("File belum diunduvgh"),
                ),

              const SizedBox(height: 16),

              // Tombol download
              RegularButton(
                judul: vm.isDownloading ? 'Mengunduh...' : 'Download File',
                onTap: (){},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
