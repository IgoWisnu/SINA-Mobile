import 'package:flutter/material.dart';
import 'dart:io';

import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';

class RingkasanPengajuanPage extends StatelessWidget {
  final String namaSiswa;
  final String tanggalIzin;
  final String jenisIzin;
  final String keterangan;
  final File? dokumen;

  const RingkasanPengajuanPage({
    Key? key,
    required this.namaSiswa,
    required this.tanggalIzin,
    required this.jenisIzin,
    required this.keterangan,
    this.dokumen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyleLabel = const TextStyle(fontWeight: FontWeight.bold);
    final textStyleValue = TextStyle(color: Colors.grey[600]);

    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Ringkasan Pengajuan",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 30),

            _buildRow("Nama Siswa", namaSiswa, textStyleLabel, textStyleValue),
            const SizedBox(height: 16),
            _buildRow(
              "Tanggal Izin",
              tanggalIzin,
              textStyleLabel,
              textStyleValue,
            ),
            const SizedBox(height: 16),
            _buildRow("Jenis Izin", jenisIzin, textStyleLabel, textStyleValue),
            const SizedBox(height: 16),
            _buildRow("Keterangan", keterangan, textStyleLabel, textStyleValue),
            const SizedBox(height: 16),
            _buildRow(
              "Dokumen Pendukung",
              dokumen != null
                  ? dokumen!.path.split('/').last
                  : "Tidak ada dokumen",
              textStyleLabel,
              textStyleValue,
            ),

            const Spacer(),

            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2972FE),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Kembali',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Ajukan logika
                      // Navigator.push / kirim data ke server
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2972FE),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Ajukan',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(
    String label,
    String value,
    TextStyle labelStyle,
    TextStyle valueStyle,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: Text(label, style: labelStyle)),
        Expanded(flex: 5, child: Text(value, style: valueStyle)),
      ],
    );
  }
}
