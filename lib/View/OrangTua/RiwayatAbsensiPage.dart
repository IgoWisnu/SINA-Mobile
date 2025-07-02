import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/TitleBar.dart';
import 'package:sina_mobile/ViewModel/OrangTua/RiwayatAbsensiViewModel.dart';
import 'package:url_launcher/url_launcher.dart';

class RiwayatAbsensiPage extends StatefulWidget {
  const RiwayatAbsensiPage({super.key});

  @override
  State<RiwayatAbsensiPage> createState() => _RiwayatAbsensiPageState();
}

class _RiwayatAbsensiPageState extends State<RiwayatAbsensiPage> {
  @override
  void initState() {
    super.initState();
    // Memuat data saat pertama kali dibuka
    Future.microtask(() {
      Provider.of<RiwayatAbsensiViewModel>(
        context,
        listen: false,
      ).fetchRiwayatAbsensi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<RiwayatAbsensiViewModel>(
          builder: (context, vm, child) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (vm.error != null) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(vm.error!, textAlign: TextAlign.center),
                ),
              );
            }

            if (vm.riwayat.isEmpty) {
              return const Center(child: Text("Tidak ada riwayat absensi"));
            }

            return RefreshIndicator(
              onRefresh: () async {
                await Provider.of<RiwayatAbsensiViewModel>(
                  context,
                  listen: false,
                ).fetchRiwayatAbsensi();
              },
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: vm.riwayat.length + 1,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const TitleBar(judul: "Riwayat Absensi");
                  }

                  final absen = vm.riwayat[index - 1];
                  final formattedDate = DateFormat(
                    'dd/MM/yyyy',
                  ).format(DateTime.parse(absen.tanggal));

                  return ListTile(
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
                              onTap: () => _launchDocument(absen.suratUrl),
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
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _launchDocument(String url) async {
    try {
      // Pastikan URL tidak null atau kosong
      if (url.isEmpty) {
        throw Exception('URL dokumen kosong');
      }

      // Pastikan UPPERCASE pada "Upload"
      String fullUrl =
          url.startsWith('http')
              ? url
              : "http://sina.pnb.ac.id:3006${url.replaceFirst('/uploads', '/Upload')}";

      // Cek apakah URL bisa diluncurkan
      if (await canLaunchUrl(Uri.parse(fullUrl))) {
        // Buka dengan browser default
        await launchUrl(
          Uri.parse(fullUrl),
          mode: LaunchMode.externalApplication, // Buka di aplikasi eksternal
        );
      } else {
        throw Exception('Tidak bisa membuka URL: $fullUrl');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Gagal membuka dokumen: ${e.toString()}"),
            duration: const Duration(seconds: 3),
          ),
        );
      }
      debugPrint('Error launching document: $e');
    }
  }
}
