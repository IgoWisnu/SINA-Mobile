import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/Guru/TugasGuru.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/CustomDatePicker.dart';
import 'package:sina_mobile/View/Component/CustomFilePicker.dart';
import 'package:sina_mobile/View/Component/CustomSnackbar.dart';
import 'package:sina_mobile/View/Component/CustomTextArea.dart';
import 'package:sina_mobile/View/Component/CustomTextField.dart';
import 'package:sina_mobile/View/Component/RegularButton.dart';
import 'package:sina_mobile/View/Component/TitleBarLine.dart';
import 'package:sina_mobile/ViewModel/Guru/EditTugasGuruViewModel.dart';
import 'package:sina_mobile/ViewModel/Guru/TugasDetailGuruViewModel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sina_mobile/service/repository/Guru/KelasGuruRepository.dart';

class EditTugasGuru extends StatefulWidget{
  final TugasItem tugas;
  const EditTugasGuru({super.key, required this.tugas});

  @override
  State<EditTugasGuru> createState() => _EditTugasGuruState();
}

class _EditTugasGuruState extends State<EditTugasGuru> {
  final _judulController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _tenggatController = TextEditingController();
  String? _filePath;

  @override
  void initState() {
    super.initState();
    print('Judul: ${widget.tugas.judul}');
    print('Deskripsi: ${widget.tugas.deskripsi}');
    print('Tenggat: ${widget.tugas.tenggatKumpul}');

    _judulController.text = widget.tugas.judul;
    _deskripsiController.text = widget.tugas.deskripsi;
    _tenggatController.text = DateFormat('dd/MM/yyyy').format(widget.tugas.tenggatKumpul);
  }

  void _submitForm(EditTugasGuruViewModel viewModel) async {
    final idTugas = widget.tugas.tugasId;
    final judul = _judulController.text;
    final deskripsi = _deskripsiController.text;
    final rawTenggat = _tenggatController.text;
    final file = _filePath;

    if (judul.isEmpty || deskripsi.isEmpty || rawTenggat.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Semua field wajib diisi")),
      );
      return;
    }

    try {
      final parsedDate = DateFormat('dd/MM/yyyy').parse(rawTenggat);
      final formattedTenggat = DateFormat('yyyy-MM-dd').format(parsedDate);

      await viewModel.editTugas(
        idTugas: idTugas,
        judul: judul,
        deskripsi: deskripsi,
        tenggat: formattedTenggat,
        filePath: file,
      );

      if (!mounted) return;
      CustomSnackbar.showSuccess(context, "Tugas Berhasil Diperbaharui");
      Navigator.pop(context);
    } catch (e) {
      CustomSnackbar.showError(context, "Tugas Gagal Diperbaharui : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EditTugasGuruViewModel>(
        builder: (context, viewModel, _) {
          return Stack(
            children: [
              Scaffold(
                appBar: CustomAppBarNoDrawer(),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleBarLine(judul: "Edit Tugas"),
                        SizedBox(height: 40),
                        Text("Judul", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        CustomTextField(controller: _judulController, hintText: "Masukkan Judul"),
                        SizedBox(height: 20),
                        Text("Deskripsi", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        CustomTextArea(controller: _deskripsiController, hintText: "Masukkan Deskripsi"),
                        SizedBox(height: 20),
                        Text("File", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        CustomFilePicker(
                          label: 'Upload File',
                          onFilePicked: (filePath) {
                            setState(() {
                              _filePath = filePath;
                            });
                            print('File dipilih: $filePath');
                          },
                        ),
                        SizedBox(height: 20),
                        Text("Tenggat", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        CustomDatePicker(
                          controller: _tenggatController,
                          hintText: 'Pilih Tenggat',
                        ),
                      ],
                    ),
                  ),
                ),
                floatingActionButton: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: RegularButton(
                    onTap: () => _submitForm(viewModel),
                    judul: "Perbaharui",
                  ),
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              ),

              // Loading Indicator
              if (viewModel.isLoading)
                Container(
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          );
        },
    );
  }
}