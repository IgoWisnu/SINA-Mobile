import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/TitleBarLine.dart';
import 'package:pdfx/pdfx.dart';
import 'package:sina_mobile/ViewModel/RaporSiswaViewModel.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

class RapotDetailMurid extends StatefulWidget{
  final String idAkademik;

  const RapotDetailMurid({super.key, required this.idAkademik});

  @override
  State<RapotDetailMurid> createState() => _RapotDetailMuridState();
}

class _RapotDetailMuridState extends State<RapotDetailMurid> {

  @override
  void initState() {
    super.initState();
    print("Calling getRapor with id: ${widget.idAkademik}");
    Future.microtask(() =>
        Provider.of<RaporSiswaViewModel>(context, listen: false).getRapor(widget.idAkademik)
    );
  }

  Future<void> _unduhRapor() async {
    final vm = Provider.of<RaporSiswaViewModel>(context, listen: false);

    try {
      final fileName = vm.rapordata!.downloadUrl!.split('/').last;
      final fullUrl = 'http://sina.pnb.ac.id:3001${vm.rapordata!.downloadUrl}';

      // Request permission
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Izin penyimpanan ditolak')),
        );
        return;
      }

      final file = await vm.downloadAndSavePdf(fullUrl, fileName);
      print("File berhasil diunduh");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File berhasil diunduh')),
      );
    } catch (e) {
      print("Gagal mengunduh file: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengunduh file')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<RaporSiswaViewModel>(context);

    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TitleBarLine(judul: "Rapot"),
            SizedBox(height: 20,),
            Text("Lampiran file"),
            SizedBox(height: 10,),
            Container(
              height: 400,
              child: vm.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : (vm.rapordata?.pdfUrl == null || vm.rapordata!.pdfUrl!.isEmpty)
                  ? Center(child: Text("Tidak ada file tersedia"))
                  : FutureBuilder<File>(
                future: () {
                  final fileName = vm.rapordata!.downloadUrl;
                  final fullUrl = 'http://sina.pnb.ac.id:3001$fileName';
                  return vm.downloadPdfFileLocal(fullUrl, fileName ?? '');
                }(),
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
            ElevatedButton.icon(
              onPressed: _unduhRapor,
              icon: Icon(Icons.download),
              label: Text("Unduh Rapor"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}