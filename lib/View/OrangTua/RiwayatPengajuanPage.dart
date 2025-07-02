import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:sina_mobile/View/Component/OrangTua/CustomAppBarOrangTua.dart';
import 'package:sina_mobile/View/Component/OrangTua/CustomOrangTuaDrawer.dart';
import 'package:sina_mobile/View/OrangTua/FormPengajuanPage.dart';
import 'package:sina_mobile/View/OrangTua/RingkasanPengajuanPage.dart';
import 'package:sina_mobile/ViewModel/OrangTua/SuratIjinViewModel.dart';

class RiwayatPengajuanPage extends StatefulWidget {
  final bool showSuccessNotification;

  const RiwayatPengajuanPage({super.key, this.showSuccessNotification = false});

  @override
  State<RiwayatPengajuanPage> createState() => _RiwayatPengajuanPageState();
}

class _RiwayatPengajuanPageState extends State<RiwayatPengajuanPage> {
  String currentMenu = 'formpengajuan';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<SuratIzinViewModel>(context, listen: false).fetchRiwayat();
    });

    if (widget.showSuccessNotification) {
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

  String formatTanggal(String isoDate) {
    try {
      final parsedDate = DateTime.parse(isoDate);
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (_) {
      return isoDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<SuratIzinViewModel>(context);

    return Scaffold(
      drawer: CustomOrangTuaDrawer(selectedMenu: currentMenu),
      key: _scaffoldKey,
      appBar: CustomAppBarOrangTua(
        onMenuPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              color: const Color(0xFF347AF0),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: const Text(
                "Riwayat Surat Izin",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child:
                vm.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : vm.error != null
                    ? Center(child: Text('Error: ${vm.error}'))
                    : vm.riwayat.isEmpty
                    ? const Center(child: Text('Tidak ada data surat izin.'))
                    : RefreshIndicator(
                      onRefresh: () async {
                        await Provider.of<SuratIzinViewModel>(
                          context,
                          listen: false,
                        ).fetchRiwayat();
                      },
                      child: ListView.separated(
                        itemCount: vm.riwayat.length,
                        separatorBuilder: (_, __) => const Divider(height: 0),
                        itemBuilder: (context, index) {
                          final izin = vm.riwayat[index];
                          return ListTile(
                            title: Text(
                              izin.jenis == 's' ? 'Sakit' : 'Izin',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(formatTanggal(izin.tanggal)),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        izin.status == "Disetujui"
                                            ? Colors.green.shade100
                                            : izin.status == "Ditolak"
                                            ? Colors.red.shade100
                                            : Colors.orange.shade100,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    izin.status,
                                    style: TextStyle(
                                      color:
                                          izin.status == "Disetujui"
                                              ? Colors.green.shade800
                                              : izin.status == "Ditolak"
                                              ? Colors.red.shade800
                                              : Colors.orange.shade800,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(Icons.chevron_right),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => RingkasanPengajuanPage(
                                        suratId: izin.id,
                                      ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF347AF0),
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FormPengajuanPage(),
                  ),
                );
              },
              child: const Text(
                "Buat Surat Izin",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
