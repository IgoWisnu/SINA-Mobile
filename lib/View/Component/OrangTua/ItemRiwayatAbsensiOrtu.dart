import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sina_mobile/ViewModel/OrangTua/RiwayatAbsensiViewModel.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemRiwayatAbsensiOrtu extends StatelessWidget {
  const ItemRiwayatAbsensiOrtu({super.key});

  @override
  Widget build(BuildContext context) {
    final riwayatList = context.watch<RiwayatAbsensiViewModel>().riwayat;
    final limitedList =
        riwayatList.length > 3 ? riwayatList.sublist(0, 3) : riwayatList;

    return Column(
      children:
          limitedList.map((absen) {
            final formattedDate = DateFormat(
              'dd/MM/yyyy',
            ).format(DateTime.parse(absen.tanggal));

            return Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    absen.status,
                    style: TextStyle(
                      color:
                          absen.status == "Alpha" ? Colors.red : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(formattedDate),
                  trailing:
                      absen.suratUrl.isNotEmpty
                          ? InkWell(
                            onTap:
                                () => _launchDocument(context, absen.suratUrl),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Lihat Surat",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(Icons.arrow_forward_ios, size: 20),
                              ],
                            ),
                          )
                          : null,
                ),
                const Divider(height: 1),
              ],
            );
          }).toList(),
    );
  }

  Future<void> _launchDocument(BuildContext context, String url) async {
    try {
      if (url.isEmpty) throw Exception('URL dokumen kosong');

      // Perbaiki jalur menjadi huruf besar "Upload"
      final fullUrl =
          url.startsWith('http')
              ? url
              : "http://sina.pnb.ac.id:3006${url.replaceFirst('/uploads', '/Upload')}";

      final uri = Uri.parse(fullUrl);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw Exception('Tidak bisa membuka URL: $fullUrl');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Gagal membuka dokumen: ${e.toString()}"),
          duration: const Duration(seconds: 3),
        ),
      );
      debugPrint('Error launching document: $e');
    }
  }
}
