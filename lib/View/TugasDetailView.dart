import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/Guru/TugasDetailResponse.dart';
import 'package:sina_mobile/Model/Guru/TugasGuru.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/DetailTugas.dart';
import 'package:sina_mobile/View/Component/ItemTugasSiswa.dart';
import 'package:sina_mobile/View/Component/RegularButton.dart';
import 'package:sina_mobile/View/Component/StatusTugas.dart';
import 'package:sina_mobile/View/Component/TitleBarLine.dart';
import 'package:sina_mobile/View/DetailTugasSiswa.dart';
import 'package:sina_mobile/View/EditTugasGuru.dart';
import 'package:sina_mobile/ViewModel/Guru/KelasDetailGuruViewModel.dart';
import 'package:sina_mobile/ViewModel/Guru/TugasDetailGuruViewModel.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:pdfx/pdfx.dart';
import 'package:open_file/open_file.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';

class TugasDetailView extends StatefulWidget{
  final TugasItem tugas;
  final String mapelId;

  const TugasDetailView({super.key, required this.tugas, required this.mapelId});


  @override
  State<TugasDetailView> createState() => _TugasDetailState();
}


class _TugasDetailState extends State<TugasDetailView> {
  final GlobalKey _menuKey = GlobalKey();

  late Future<File> _pdfFile;
  File? _downloadedFile;

  TugasDetail? _currentTugas;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTugasDetail();

    // Ambil data kelas saat widget dibuka
    Future.microtask(() =>
        Provider.of<TugasDetailGuruViewModel>(context, listen: false).fetchSiswaMengumpulkan(idMapel: widget.mapelId, idTugas: widget.tugas.tugasId));

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

  void _fetchTugasDetail() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final result = await Provider.of<TugasDetailGuruViewModel>(context, listen: false)
          .getDetailTugas(idTugas: widget.tugas.tugasId);

      print(result);
      setState(() {
        _currentTugas = result;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Gagal memuat detail tugas: $e');
    }
  }

  //popup
  void _showPopupMenu(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {

      if (_menuKey.currentContext == null) {
        print("menuKey context is null");
        return;
      }

      final RenderBox renderBox = _menuKey.currentContext!.findRenderObject() as RenderBox;
      final Offset offset = renderBox.localToGlobal(Offset.zero);
      final Size size = renderBox.size;

      final selected = await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(
          offset.dx,
          offset.dy + size.height,
          offset.dx + size.width,
          offset.dy,
        ),
        items: [
          PopupMenuItem(value: 'edit', child: Text('Edit Materi')),
          PopupMenuItem(value: 'hapus', child: Text('Hapus Materi')),
          PopupMenuItem(value: 'peringkat', child: Text('Peringkat Siswa')),
        ],
      );

      // Tangani aksi popup
      if (selected == 'edit') {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => EditTugasGuru(tugas: widget.tugas)),
        );
        _fetchTugasDetail(); // 🔁 setelah kembali dari Edit
      } else if (selected == 'hapus') {
        Provider.of<TugasDetailGuruViewModel>(context, listen: false).deleteTugas(idTugas: widget.tugas.tugasId);
        Navigator.pop(context);
      } else if (selected == 'peringkat') {
        // TODO: Implementasi peringkat
      }
    });
  }

  Widget _buildActionItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        title,
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
      onTap: onTap,
    );
  }


  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TugasDetailGuruViewModel>(context);
    final pdfUrl = "http://sina.pnb.ac.id:3007/Upload/tugas/${_currentTugas?.lampiran ?? ''}";

    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              StatusTugas(
                tugas : _currentTugas!,
                action: () => _showPopupMenu(context),
                menuKey: _menuKey,
              ),
              SizedBox(height: 20,),
              DetailTugas(
                judul: _currentTugas?.judul ?? 'Tidak ada',
                keterangan: _currentTugas?.deskripsi ?? 'Tidak ada',
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
              RegularButton(onTap: openWithExternalApp, judul: "Buka Lampiran"),
              SizedBox(height: 20,),
              TitleBarLine(judul: "Dikumpulkan"),
              vm.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : vm.error != null
                  ? Center(child: Text('Error: ${vm.error}'))
                  : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: vm.kelasList.length,
                itemBuilder: (context, index) {
                  final itemTugas = vm.kelasList[index];
                  return ItemTugasSiswa(
                    nama: itemTugas.namaSiswa,
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailTugasSiswa(
                            tugasSiswa : itemTugas,
                            idMapel: widget.mapelId,
                            krsId: itemTugas.krsId,
                            idTugas: widget.tugas.tugasId,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),

      ),
    );
  }
}
