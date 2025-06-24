import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/CustomDatePicker.dart';
import 'package:sina_mobile/View/Component/CustomFilePicker.dart';
import 'package:sina_mobile/View/Component/CustomSnackbar.dart';
import 'package:sina_mobile/View/Component/CustomTextArea.dart';
import 'package:sina_mobile/View/Component/CustomTextField.dart';
import 'package:sina_mobile/View/Component/RegularButton.dart';
import 'package:sina_mobile/View/Component/TitleBarLine.dart';
import 'package:sina_mobile/ViewModel/Guru/TugasDetailGuruViewModel.dart';
import 'package:intl/intl.dart';

class TambahTugas extends StatefulWidget{
  final String idMapel;

  const TambahTugas({super.key, required this.idMapel});

  @override
  State<TambahTugas> createState() => _TambahTugasState();
}

class _TambahTugasState extends State<TambahTugas> {
  final TugasDetailGuruViewModel _viewModel = TugasDetailGuruViewModel();

  final _judulController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _tenggatController = TextEditingController();

  String? _filePath;

  @override
  void dispose() {
    _judulController.dispose();
    _deskripsiController.dispose();
    _tenggatController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    final idMapel = widget.idMapel;
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
      // Misalnya kamu pakai format dd/MM/yyyy di CustomDatePicker
      final parsedDate = DateFormat('dd/MM/yyyy').parse(rawTenggat);
      final formattedTenggat = DateFormat('yyyy-MM-dd').format(parsedDate);

      await _viewModel.tambahTugas(
        idMapel: idMapel,
        judul: judul,
        deskripsi: deskripsi,
        tenggat: formattedTenggat,
        filePath: file ?? '',
      );

      CustomSnackbar.showSuccess(context, "Tugas Berhasil Ditambahkan");

      Navigator.pop(context);
    } catch (e) {
      CustomSnackbar.showSuccess(context, "Tugas Gagal Ditambahkan");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleBarLine(judul: "Tambah Tugas"),
                SizedBox(height: 40),
                Text("Judul", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                CustomTextField(controller: _judulController, hintText: "Masukan Judul"),
                SizedBox(height: 20),
                Text("Deskripsi", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                CustomTextArea(controller: _deskripsiController, hintText: "Masukan Deskripsi"),
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
              ]),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: RegularButton(onTap: _submitForm, judul: "Tambahkan"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
