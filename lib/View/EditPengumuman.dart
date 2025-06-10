import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/Berita.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/CustomFilePicker.dart';
import 'package:sina_mobile/View/Component/CustomSnackbar.dart';
import 'package:sina_mobile/View/Component/CustomTextField.dart';
import 'package:sina_mobile/View/Component/RegularButton.dart';
import 'package:sina_mobile/View/Component/TitleBarLine.dart';
import 'package:sina_mobile/View/Pengumuman.dart';
import 'package:sina_mobile/ViewModel/Guru/PengumumanGuruViewModel.dart';
import 'package:sina_mobile/service/api/ApiServiceGuru.dart';
import 'package:sina_mobile/service/repository/Guru/BeritaGuruRepository.dart';

import 'Component/CustomTextArea.dart';

class EditPengumuman extends StatefulWidget{
  final Berita berita;

  const EditPengumuman({super.key, required this.berita});


  @override
  State<EditPengumuman> createState() => _EditPengumumanState();
}

class _EditPengumumanState extends State<EditPengumuman> {

  final PengumumanGuruViewModel _viewModel = PengumumanGuruViewModel(repository: BeritaGuruRepository(ApiServiceGuru()));

  final _judulController = TextEditingController();
  final _deskripsiController = TextEditingController();

  String? _filePath;

  @override
  void dispose() {
    _judulController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _judulController.text = widget.berita.judul ?? "";
    _deskripsiController.text = widget.berita.isi ?? ""; // Isi deskripsi
  }

  void _submitForm() async {
    final judul = _judulController.text;
    final deskripsi = _deskripsiController.text;
    final file = _filePath;

    if (judul.isEmpty || deskripsi.isEmpty ) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Semua field wajib diisi")),
      );
      return;
    }

    try {
      // Misalnya kamu pakai format dd/MM/yyyy di CustomDatePicker
      await _viewModel.tambahBerita(
        judul: judul,
        deskripsi: deskripsi,
        filePath: file ?? '',
      );


      CustomSnackbar.showSuccess(context, "Tugas berhasil Berita");
      Navigator.pop(context);
    } catch (e) {
      CustomSnackbar.showError(context, "Gagal menambahkan berita $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TitleBarLine(judul: "Tambah Pengumuman"),
            SizedBox(height: 20,),
            Text("Judul", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
            SizedBox(height: 5,),
            CustomTextField(controller: _judulController, hintText: "Masukan judul",),
            SizedBox(height: 5,),
            Text("Deskripsi", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
            SizedBox(height: 5,),
            CustomTextArea(controller: _deskripsiController, hintText: "Masukan Deskripsi",),
            SizedBox(height: 5,),
            CustomFilePicker(label: "Upload Gambar", onFilePicked: (filePath) {
              setState(() {
                _filePath = filePath;
              });
              print('File dipilih: $filePath');
            },),
            SizedBox(height: 20,),
            RegularButton(onTap: (){
              _submitForm();
            }, judul: "Simpan"),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}