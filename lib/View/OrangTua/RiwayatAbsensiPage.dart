import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/OrangTua/TitleBarRiwayatAbsensi.dart';
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
    Future.microtask(() {
      Provider.of<RiwayatAbsensiViewModel>(
        context,
        listen: false,
      ).fetchRiwayatAbsensi();
    });
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "alpha":
        return Colors.red;
      case "sakit":
        return Colors.orange;
      case "izin":
        return Colors.blue;
      default:
        return Colors.black;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case "alpha":
        return Icons.cancel;
      case "sakit":
        return Icons.sick;
      case "izin":
        return Icons.assignment_turned_in;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
              onRefresh: () => vm.fetchRiwayatAbsensi(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleBarRiwayatAbsensi(judul: "Riwayat Absensi"),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.separated(
                      itemCount: vm.riwayat.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final absen = vm.riwayat[index];
                        final formattedDate = DateFormat(
                          'dd/MM/yyyy',
                        ).format(DateTime.parse(absen.tanggal));

                        return Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  _getStatusIcon(absen.status),
                                  color: _getStatusColor(absen.status),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        absen.status,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: _getStatusColor(absen.status),
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        formattedDate,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                if (absen.suratUrl != null &&
                                    absen.suratUrl!.isNotEmpty)
                                  IconButton(
                                    onPressed:
                                        () => _launchDocument(absen.suratUrl!),
                                    icon: const Icon(
                                      Icons.picture_as_pdf,
                                      color: Colors.indigo,
                                    ),
                                    tooltip: "Lihat Surat",
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _launchDocument(String url) async {
    try {
      if (url.isEmpty) throw Exception('URL dokumen kosong');

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
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Gagal membuka dokumen: ${e.toString()}"),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }
}
