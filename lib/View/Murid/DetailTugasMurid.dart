import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/Tugas.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/CustomFilePicker.dart';
import 'package:sina_mobile/View/Component/CustomSnackbar.dart';
import 'package:sina_mobile/View/Component/CustomTextArea.dart';
import 'package:sina_mobile/View/Component/DetailTugas.dart';
import 'package:sina_mobile/View/Component/RegularButton.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';
import 'package:sina_mobile/View/Murid/EditTugasMurid.dart';
import 'package:sina_mobile/ViewModel/DetailTugasViewModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:pdfx/pdfx.dart';
import 'package:open_file/open_file.dart';


class DetailTugasMurid extends StatefulWidget {
  final Tugas tugas;

  const DetailTugasMurid({super.key, required this.tugas});

  @override
  State<DetailTugasMurid> createState() => _DetailTugasMuridState();
}

class _DetailTugasMuridState extends State<DetailTugasMurid> {
  final TextEditingController _deskripsiController = TextEditingController();
  final Detailtugasviewmodel _viewModel = Detailtugasviewmodel();

  late Future<File> _pdfFile;
  File? _downloadedFile;
  
  String? _selectedFilePath;
  bool _isSubmitting = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _deskripsiController.text = widget.tugas.uraian ?? ""; // Isi deskripsi
    _selectedFilePath = widget.tugas.lampiran;             // Isi file yang sudah dikumpulkan (jika ada)

    final url = 'http://sina.pnb.ac.id:3007/Upload/tugas/${widget.tugas.lampiran}';
    final fileName = widget.tugas.lampiran ?? 'file.pdf';

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

  void _submitTugas() async {
    if (_selectedFilePath == null || _deskripsiController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("File dan deskripsi harus diisi")),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      await _viewModel.kumpulkanTugass(
        tugasId: widget.tugas.tugasId,
        filePath: _selectedFilePath!,
        deskripsi: _deskripsiController.text,
      );

      CustomSnackbar.showSuccess(context, "Berhasil Mengumpul Tugas");

      Navigator.pop(context, true); // mengirim flag "data berubah"
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal mengumpulkan tugas: $e")),
      );
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  bool get _tugasSudahDikumpulkan =>
      widget.tugas.uraian != null || widget.tugas.fileJawaban != null;

  @override
  Widget build(BuildContext context) {
    final pdfUrl = "http://sina.pnb.ac.id:3007/Upload/tugas/${widget.tugas.lampiran}";

    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                DetailTugas(
                  judul: widget.tugas.namaTugas,
                  keterangan: widget.tugas.deskripsi,
                ),
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
                RegularButton(onTap: openWithExternalApp, judul: "Buka dengan"),
                SizedBox(height: 5,),
                RegularButton(onTap: _openKumpulkanTugasSheet, judul: "Kumpul Tugas")
                ],
            ),
          ),
        ),
      ),
    );
  }

  void _openKumpulkanTugasSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: _buildKumpulkanTugasForm(),
      ),
    );
  }

  Widget _buildKumpulkanTugasForm() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Text(
            "Kumpulkan Tugas",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 10),

          if (_tugasSudahDikumpulkan) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Tugas sudah terkumpul",
                style: TextStyle(
                  color: Colors.green.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            CustomFilePicker(
              label: widget.tugas.fileJawaban.toString(),
              onFilePicked: (filePath) {
                setState(() {
                  _selectedFilePath = filePath;
                });
              },
            ),
            SizedBox(height: 10),
            CustomTextArea(
              controller: _deskripsiController,
              disable: true,
            ),
            SizedBox(height: 10),
            RegularButton(
              judul: "Edit Tugas",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditTugasMurid(tugas: widget.tugas),
                  ),
                );
              },
            ),
          ] else ...[
            CustomFilePicker(
              label: "Upload Tugas",
              onFilePicked: (filePath) {
                setState(() {
                  _selectedFilePath = filePath;
                });
              },
            ),
            SizedBox(height: 10),
            CustomTextArea(
              controller: _deskripsiController,
              hintText: "Tambahkan deskripsi...",
            ),
            SizedBox(height: 10),
            _isSubmitting
                ? Center(child: CircularProgressIndicator())
                : RegularButton(
              onTap: _submitTugas,
              judul: "Kumpulkan",
            ),
          ],
          SizedBox(height: 20),
        ],
      ),
    );
  }

}


