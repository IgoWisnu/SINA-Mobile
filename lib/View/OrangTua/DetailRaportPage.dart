// FINAL CODE: DetailRapotPage (Rapih & Responsif Table)

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/TitleBarLine.dart';
import 'package:pdfx/pdfx.dart';
import 'package:sina_mobile/ViewModel/OrangTua/RaporFileViewModel.dart';
import 'package:permission_handler/permission_handler.dart';

class DetailRapotPage extends StatefulWidget {
  final String nis;
  const DetailRapotPage({super.key, required this.nis});

  @override
  State<DetailRapotPage> createState() => _DetailRapotPageState();
}

class _DetailRapotPageState extends State<DetailRapotPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final vm = Provider.of<RaporFileViewModel>(context, listen: false);
      vm.fetchRapor(widget.nis);
    });
  }

  Future<void> _unduhRapor() async {
    final vm = Provider.of<RaporFileViewModel>(context, listen: false);

    try {
      final fileName = vm.rapor!.filename;
      final file = await vm.downloadRaporFile(vm.rapor!.raporUrl, fileName);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('File berhasil diunduh')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Gagal mengunduh file')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarNoDrawer(),
      body: Consumer<RaporFileViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage != null) {
            return Center(child: Text(viewModel.errorMessage!));
          }

          final data = viewModel.rapor;

          if (data == null) {
            return const Center(child: Text('Data rapor tidak ditemukan.'));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleBarLine(judul: "Rapot"),
                  const SizedBox(height: 20),

                  // Tabel Nilai Rapih dan Responsif
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 20,
                        horizontalMargin: 12,
                        headingRowColor: MaterialStateProperty.all(Colors.blue),
                        headingTextStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        columns: const [
                          DataColumn(label: Text("Mata Pelajaran")),
                          DataColumn(label: Text("Pengetahuan"), numeric: true),
                          DataColumn(
                            label: Text("Keterampilan"),
                            numeric: true,
                          ),
                          DataColumn(label: Text("KKM"), numeric: true),
                          DataColumn(label: Text("Status")),
                          DataColumn(label: Text("Guru Pengampu")),
                        ],
                        rows:
                            data.nilai.map((mapel) {
                              return DataRow(
                                cells: [
                                  DataCell(
                                    SizedBox(
                                      width: 180,
                                      child: Text(
                                        mapel.namaMapel,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      mapel.pengetahuan?.toStringAsFixed(1) ??
                                          '-',
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      mapel.keterampilan?.toStringAsFixed(1) ??
                                          '-',
                                    ),
                                  ),
                                  DataCell(Text(mapel.kkm.toString())),
                                  DataCell(Text(mapel.status)),
                                  DataCell(
                                    SizedBox(
                                      width: 120,
                                      child: Text(
                                        mapel.guruPengampu ?? '-',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    "Lampiran File",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),

                  FutureBuilder<File>(
                    future: viewModel.downloadRaporFile(
                      data.raporUrl,
                      data.filename,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text('Gagal memuat file PDF'),
                        );
                      } else {
                        final file = snapshot.data!;
                        return SizedBox(
                          height: 400,
                          child: PdfViewPinch(
                            controller: PdfControllerPinch(
                              document: PdfDocument.openFile(file.path),
                            ),
                          ),
                        );
                      }
                    },
                  ),

                  const SizedBox(height: 16),

                  // Tombol Unduh
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
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
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
