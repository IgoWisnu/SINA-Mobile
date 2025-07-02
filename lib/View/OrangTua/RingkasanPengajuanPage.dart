import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/ViewModel/OrangTua/SuratIjinDetailViewModel.dart';
import 'package:sina_mobile/service/api/ApiServisOrangTua.dart';
import 'package:sina_mobile/service/repository/OrangTua/SuratIjinDetailRepository.dart';
import 'package:url_launcher/url_launcher.dart';

class RingkasanPengajuanPage extends StatefulWidget {
  final String suratId;
  final bool isNewSubmission;

  const RingkasanPengajuanPage({
    super.key,
    required this.suratId,
    this.isNewSubmission = false,
  });

  @override
  State<RingkasanPengajuanPage> createState() => _RingkasanPengajuanPageState();
}

class _RingkasanPengajuanPageState extends State<RingkasanPengajuanPage> {
  late DetailSuratIzinViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = DetailSuratIzinViewModel(
      repository: SuratIjinDetailRepository(ApiServiceOrangTua()),
    );
    viewModel.fetchDetail(widget.suratId);

    if (widget.isNewSubmission) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showSuccessNotification();
      });
    }
  }

  void _showSuccessNotification() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Surat berhasil dikirim, mohon tunggu konfirmasi dari admin',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 5),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Future<void> _launchDocument(String url) async {
    try {
      // Pastikan URL tidak null atau kosong
      if (url.isEmpty) {
        throw Exception('URL dokumen kosong');
      }

      // Perbaikan URL jika diperlukan
      String fullUrl;
      if (url.startsWith('http')) {
        fullUrl = url; // Jika URL sudah lengkap
      } else {
        fullUrl = "http://sina.pnb.ac.id:3006$url";
      }

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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<DetailSuratIzinViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return Scaffold(
              appBar: CustomAppBarNoDrawer(),
              body: const Center(child: CircularProgressIndicator()),
            );
          }

          if (vm.error != null) {
            return Scaffold(
              appBar: CustomAppBarNoDrawer(),
              body: Center(child: Text("Error: ${vm.error}")),
            );
          }

          final detail = vm.detail!;
          final tanggalFormatted = DateFormat(
            'dd/MM/yyyy',
          ).format(DateTime.parse(detail.tanggal));

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomAppBarNoDrawer(),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  const Center(
                    child: Text(
                      "Ringkasan Pengajuan Surat Izin",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Status Box
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color:
                          detail.status == 'Disetujui'
                              ? Colors.green.shade400
                              : detail.status == 'Ditolak'
                              ? Colors.red.shade400
                              : Colors.orange.shade400,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Text(
                          "Status",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          detail.status,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Detail Surat Izin Box
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade700,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "Detail Surat Izin",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  _buildDetailItem("Nama Siswa:", detail.namaSiswa),
                  _buildDetailItem("Tanggal Izin:", tanggalFormatted),
                  _buildDetailItem(
                    "Jenis Izin:",
                    detail.jenis == 's' ? 'Sakit' : 'Izin',
                  ),
                  _buildDetailItem("Keterangan:", detail.uraian),
                  _buildDetailItem(
                    "Dokumen Pendukung:",
                    detail.suratUrl.split('/').last,
                  ),

                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.picture_as_pdf),
                    label: const Text("Lihat Dokumen"),
                    onPressed: () {
                      if (detail.suratUrl.isNotEmpty) {
                        _launchDocument(detail.suratUrl);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Dokumen tidak tersedia"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
