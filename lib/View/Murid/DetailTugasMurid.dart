import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/Tugas.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/CustomFilePicker.dart';
import 'package:sina_mobile/View/Component/CustomTextArea.dart';
import 'package:sina_mobile/View/Component/DetailTugas.dart';
import 'package:sina_mobile/View/Component/RegularButton.dart';
import 'package:sina_mobile/View/Murid/EditTugasMurid.dart';
import 'package:sina_mobile/ViewModel/Detailtugasviewmodel.dart';

class DetailTugasMurid extends StatefulWidget {
  final Tugas tugas;

  const DetailTugasMurid({super.key, required this.tugas});

  @override
  State<DetailTugasMurid> createState() => _DetailTugasMuridState();
}

class _DetailTugasMuridState extends State<DetailTugasMurid> {
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

      Navigator.pop(context); // Kembali ke halaman sebelumnya
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
      widget.tugas.uraian != null || widget.tugas.fileJawaban != null;

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
                SizedBox(height: 20),
                DetailTugas(
                  judul: widget.tugas.namaTugas,
                  keterangan: widget.tugas.deskripsi,
                ),
                SizedBox(height: 20),
                Text(
                  "Kumpulkan Tugas",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),

                // Kondisi jika tugas sudah dikumpulkan
                if (_tugasSudahDikumpulkan) ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Tugas sudah terkumpul",
                      style: TextStyle(
                        color: Colors.green.shade800,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
                if (_tugasSudahDikumpulkan) ...[
                  // File Picker dan Deskripsi
                  CustomFilePicker(
                    label: widget.tugas.fileJawaban.toString(),
                    onFilePicked: (filePath) {
                      setState(() {
                        _selectedFilePath = filePath;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  CustomTextArea(
                    controller: _deskripsiController,
                    disable: true
                  ),
                  SizedBox(height: 10),
                  RegularButton(
                    judul: "Edit Tugas",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditTugasMurid(tugas: widget.tugas),
                        ),
                      );
                    },
                  ),
                ],
                if (!_tugasSudahDikumpulkan) ...[
                  //set deskripsi agar terisi


                  // File Picker dan Deskripsi
                  CustomFilePicker(
                    label: "Upload Tugas",
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
                  SizedBox(height: 10),
                  // Tombol submit
                  _isSubmitting
                      ? Center(child: CircularProgressIndicator())
                      : RegularButton(
                    onTap: _submitTugas,
                    judul: "Kumpulkan",
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
