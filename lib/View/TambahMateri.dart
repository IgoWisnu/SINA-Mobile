import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/CustomFilePicker.dart';
import 'package:sina_mobile/View/Component/CustomSnackbar.dart';
import 'package:sina_mobile/View/Component/CustomTextArea.dart';
import 'package:sina_mobile/View/Component/CustomTextField.dart';
import 'package:sina_mobile/View/Component/RegularButton.dart';
import 'package:sina_mobile/View/Component/TitleBarLine.dart';
import 'package:sina_mobile/ViewModel/Guru/TambahMateriViewModel.dart';

class TambahMateri extends StatefulWidget{
  final String idMapel;

  const TambahMateri({super.key, required this.idMapel});

  @override
  State<TambahMateri> createState() => _TambahMateriState();
}

class _TambahMateriState extends State<TambahMateri> {
  final Tambahmateriviewmodel _viewModel = Tambahmateriviewmodel();

  final _judulController = TextEditingController();
  final _deskripsiController = TextEditingController();
  String? _filePath;

  @override
  void dispose() {
    _judulController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    final idMapel = widget.idMapel;
    final judul = _judulController.text;
    final deskripsi = _deskripsiController.text;
    final file = _filePath;

    if (judul.isEmpty || deskripsi.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Semua field wajib diisi")),
      );
      return;
    }

    try {
      await _viewModel.tambahMateri(
        idMapel: idMapel,
        judul: judul,
        deskripsi: deskripsi,
        filePath: file ?? '',
      );

      CustomSnackbar.showSuccess(context, "Materi Berhasil Ditambahkan");

      Navigator.pop(context);
    } catch (e) {
      CustomSnackbar.showError(context, "Materi Gagal Ditambahkan");
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleBarLine(judul: "Tambah Materi"),
            SizedBox(height: 40,),
            Text("Judul", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            CustomTextField(controller: _judulController, hintText: "Masukan Judul",),
            SizedBox(height: 20,),
            Text("Deskripsi", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            CustomTextArea(controller: _deskripsiController, hintText: "Masukan Deskripsi",),
            SizedBox(height: 20,),
            Text("File", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
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
          ],
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