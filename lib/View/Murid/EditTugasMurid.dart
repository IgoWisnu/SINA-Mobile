import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/Tugas.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/CustomFilePicker.dart';
import 'package:sina_mobile/View/Component/CustomTextArea.dart';
import 'package:sina_mobile/View/Component/DetailTugas.dart';
import 'package:sina_mobile/View/Component/RegularButton.dart';
import 'package:sina_mobile/View/Component/TitleBarLine.dart';
import 'package:sina_mobile/ViewModel/Detailtugasviewmodel.dart';

class EditTugasMurid extends StatefulWidget {
  final Tugas tugas;

  const EditTugasMurid({super.key, required this.tugas});

  @override
  State<EditTugasMurid> createState() => _EditTugasMuridState();
}

class _EditTugasMuridState extends State<EditTugasMurid> {
  final TextEditingController _deskripsiController = TextEditingController();
  final Detailtugasviewmodel _viewModel = Detailtugasviewmodel();

  String? _selectedFilePath;
  bool _isSubmitting = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _deskripsiController.text = widget.tugas.uraian ?? ""; // Isi deskripsi
    _selectedFilePath = widget.tugas.lampiran;             // Isi file yang sudah dikumpulkan (jika ada)
  }


  void _submitTugas() async {
    if (_selectedFilePath == null || _deskripsiController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("File dan deskripsi harus diisi")),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      await _viewModel.kumpulkanTugas(
        idTugas: widget.tugas.tugasId,
        filePath: _selectedFilePath!,
        deskripsi: _deskripsiController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Tugas berhasil dikumpulkan")),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal mengumpulkan tugas: $e")),
      );
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  bool get _tugasSudahDikumpulkan =>
      widget.tugas.uraian != null || widget.tugas.lampiran != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleBarLine(judul: "Edit Tugas"),
                SizedBox(height: 20),
                DetailTugas(
                  judul: widget.tugas.namaTugas,
                  keterangan: widget.tugas.deskripsi,
                ),
                SizedBox(height: 20),
                Text(
                  "Edit Tugas",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                CustomFilePicker(
                  label: widget.tugas.lampiran.toString(),
                  onFilePicked: (filePath) {
                    setState(() {
                      _selectedFilePath = filePath;
                    });
                  },
                ),

                SizedBox(height: 10),
                CustomTextArea(
                  controller: _deskripsiController,
                  hintText: "Tambahkan deskripsi...",
                ),
                SizedBox(height: 20),
                RegularButton(onTap: () {
                  Navigator.pop(context); // Batalkan
                }, judul: 'Batalkan'),
                SizedBox(height: 10),
                _isSubmitting
                    ? Center(child: CircularProgressIndicator())
                    : RegularButton(
                  onTap: _submitTugas,
                  judul: "Kumpulkan Kembali",
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
