// lib/View/VerifikasiSuratIzinDetail.dart
import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/RegularButton.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';
import 'package:provider/provider.dart';
import '../Model/Guru/SuratIzinModel.dart';
import '../ViewModel/Guru/SuratIzinViewModel.dart';

class VerifikasiSuratIzinDetail extends StatelessWidget {
  final SuratIzinModel surat;

  const VerifikasiSuratIzinDetail({required this.surat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Detail Surat Izin",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                alignment: Alignment.centerLeft,
              ),
              Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "Nama Siswa",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          width: 150,
                        ),
                        SizedBox(width: 100),
                        Text(surat.namaSiswa),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "Tanggal Izin",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          width: 150,
                        ),
                        SizedBox(width: 100),
                        Text(surat.formattedDate),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "Jenis Izin",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          width: 150,
                        ),
                        SizedBox(width: 100),
                        Text(surat.keterangan),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "Keterangan",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          width: 150,
                        ),
                        SizedBox(width: 100),
                        Expanded(child: Text(surat.keterangan)),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "Surat",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          width: 150,
                        ),
                        SizedBox(width: 100),
                        Text(surat.surat),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // VerifikasiSuratIzinDetail.dart
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Consumer<SuratIzinViewModel>(
          builder: (context, viewModel, _) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (viewModel.errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      viewModel.errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                if (viewModel.isLoading)
                  CircularProgressIndicator()
                else
                  RegularButton(
                    // Di dalam onTap:
                    onTap: () async {
                      final navigator = Navigator.of(context);
                      final scaffold = ScaffoldMessenger.of(context);

                      final confirmed = await showConfirmationDialog(context);
                      if (!confirmed) return;

                      final success = await viewModel.approveLetter(
                        surat.absensiId,
                      );

                      if (success) {
                        navigator.pop();
                        scaffold.showSnackBar(
                          SnackBar(content: Text('Berhasil disetujui')),
                        );
                      }
                    },
                    judul: "Setujui",
                  ),
              ],
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<bool> showConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text('Konfirmasi'),
                content: Text('Anda yakin ingin menyetujui surat ini?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text('Batal'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text('Setujui'),
                  ),
                ],
              ),
        ) ??
        false;
  }
}
