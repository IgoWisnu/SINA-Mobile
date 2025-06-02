import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/OrangTua/CustomOrangTuaDrawer.dart';

class RiwayatAbsensiPage extends StatelessWidget {
  RiwayatAbsensiPage({super.key});
  final Map<String, double> dataMap = {
    "Hadir": 320,
    "Izin": 20,
    "Sakit": 10,
    "Alpha": 17,
  };

  final List<Map<String, String>> riwayat = [
    {"status": "Alpha", "tanggal": "35/04/2025", "keterangan": ""},
    {"status": "Sakit", "tanggal": "35/04/2025", "keterangan": "Surat Izin"},
    {"status": "Sakit", "tanggal": "35/04/2025", "keterangan": "Surat Izin"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarNoDrawer(),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Riwayat Absensi
            Container(
              width: double.infinity,
              color: Colors.blue[700],
              padding: const EdgeInsets.all(12),
              child: const Text(
                "Riwayat Absensi",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),

            ...riwayat.map((absen) {
              return Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      absen["status"]!,
                      style: TextStyle(
                        color:
                            absen["status"] == "Alpha"
                                ? Colors.red
                                : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(absen["tanggal"]!),
                    trailing:
                        absen["keterangan"] != ""
                            ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  absen["keterangan"]!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(Icons.arrow_forward_ios, size: 16),
                              ],
                            )
                            : null,
                  ),
                  const Divider(height: 1),
                ],
              );
            }).toList(),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
