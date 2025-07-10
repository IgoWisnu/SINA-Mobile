import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/OrangTua/TitleBarRiwayatAbsensi.dart';
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
              onRefresh: () async {
                await Provider.of<RiwayatAbsensiViewModel>(
                  context,
                  listen: false,
                ).fetchRiwayatAbsensi();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleBarRiwayatAbsensi(judul: "Riwayat Absensi"),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: vm.riwayat.length,
                      separatorBuilder:
                          (_, __) =>
                              const Divider(height: 1, color: Colors.black),
                      itemBuilder: (context, index) {
                        final absen = vm.riwayat[index];
                        final formattedDate = DateFormat(
                          'dd/MM/yyyy',
                        ).format(DateTime.parse(absen.tanggal));

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Row(
                            children: [
                              // Status
                              Expanded(
                                flex: 2,
                                child: Text(
                                  absen.status,
                                  style: TextStyle(
                                    color:
                                        absen.status == "Alpha"
                                            ? Colors.red
                                            : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),

                              // Tanggal
                              Expanded(
                                flex: 2,
                                child: Text(
                                  formattedDate,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),

                              // Surat Izin
                              if (absen.suratUrl.isNotEmpty)
                                Expanded(
                                  flex: 3,
                                  child: InkWell(
                                    onTap:
                                        () => _launchDocument(absen.suratUrl),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: const [
                                        Text(
                                          "Surat Izin",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Icon(Icons.arrow_forward_ios, size: 16),
                                      ],
                                    ),
                                  ),
                                )
                              else
                                const Expanded(flex: 3, child: SizedBox()),
                            ],
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

      String fullUrl =
          url.startsWith('http')
              ? url
              : "http://sina.pnb.ac.id:3006${url.replaceFirst('/uploads', '/Upload')}";

      if (await canLaunchUrl(Uri.parse(fullUrl))) {
        await launchUrl(
          Uri.parse(fullUrl),
          mode: LaunchMode.externalApplication,
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
