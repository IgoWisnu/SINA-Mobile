import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/TitleBarLine.dart';
import 'package:pdfx/pdfx.dart';
import 'package:sina_mobile/ViewModel/OrangTua/RaporDetailViewModel.dart';
import 'package:permission_handler/permission_handler.dart';

class DetailRapotPage extends StatefulWidget {
  final String krsId;

  const DetailRapotPage({super.key, required this.krsId});

  @override
  State<DetailRapotPage> createState() => _DetailRapotPageState();
}

class _DetailRapotPageState extends State<DetailRapotPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final vm = Provider.of<RaporDetailViewModel>(context, listen: false);
      vm.fetchDetail(widget.krsId);
    });
  }

  Future<void> _unduhRapor() async {
    final vm = Provider.of<RaporDetailViewModel>(context, listen: false);

    try {
      final fileName = vm.raporDetail!.downloadUrl!.split('/').last;
      final fullUrl =
          'http://sina.pnb.ac.id:3001${vm.raporDetail!.downloadUrl}';

      final status = await Permission.storage.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Izin penyimpanan ditolak')));
        return;
      }

      final file = await vm.downloadAndSavePdf(fullUrl, fileName);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('File berhasil diunduh')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal mengunduh file')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarNoDrawer(),
      body: Consumer<RaporDetailViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage != null) {
            return Center(child: Text(viewModel.errorMessage!));
          }

          final data = viewModel.raporDetail;

          if (data == null) {
            return const Center(child: Text('Data rapor tidak ditemukan.'));
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleBarLine(judul: "Rapot"),
                const SizedBox(height: 20),

                // Tabel Nilai
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(Colors.blue),
                    headingTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    columns: const [
                      DataColumn(label: Text("Mata Pelajaran")),
                      DataColumn(label: Text("Nilai")),
                      DataColumn(label: Text("Kategori")),
                    ],
                    rows:
                        data.nilai
                            .map(
                              (mapel) => DataRow(
                                cells: [
                                  DataCell(Text(mapel.namaMapel)),
                                  DataCell(Text(mapel.nilai.toString())),
                                  DataCell(Text(mapel.kategori)),
                                ],
                              ),
                            )
                            .toList(),
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  "Lampiran File",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),

                Expanded(
                  child:
                      (data.pdfUrl == null || data.pdfUrl!.isEmpty)
                          ? const Center(child: Text("Tidak ada file tersedia"))
                          : FutureBuilder<File>(
                            future: () {
                              final fullUrl =
                                  'http://sina.pnb.ac.id:3001${data.downloadUrl}';
                              return viewModel.downloadPdfFileLocal(
                                fullUrl,
                                data.downloadUrl ?? '',
                              );
                            }(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasError) {
                                return const Center(
                                  child: Text('Gagal memuat file PDF'),
                                );
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
                  icon: const Icon(Icons.download),
                  label: const Text("Unduh Rapor"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
