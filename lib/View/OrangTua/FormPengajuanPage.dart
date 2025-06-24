import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/OrangTua/CustomAppBarOrangTua.dart';
import 'package:sina_mobile/View/Component/OrangTua/CustomOrangTuaDrawer.dart';
import 'package:sina_mobile/ViewModel/OrangTua/AjukanSuratViewModel.dart';
import 'package:sina_mobile/service/api/ApiServisOrangTua.dart';
import 'package:sina_mobile/service/repository/OrangTua/AjukanSuratRepository.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class FormPengajuanPage extends StatefulWidget {
  @override
  _FormPengajuanPageState createState() => _FormPengajuanPageState();
}

class _FormPengajuanPageState extends State<FormPengajuanPage> {
  final TextEditingController _nisController = TextEditingController();
  final TextEditingController _uraianController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();
  String currentMenu = 'formpengajuan';
  String _selectedJenis = 's'; // 's' = Sakit, 'i' = Izin
  File? _file;

  final _viewModel = AjukanSuratViewModel(
    repository: AjukanSuratRepository(apiService: ApiServiceOrangTua()),
  );

  Future<void> _pickTanggalIzin() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      _tanggalController.text = DateFormat('yy-MM-dd').format(picked);
    }
  }

  Future<void> _pickDokumen() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null && result.files.single.path != null) {
      setState(() {
        _file = File(result.files.single.path!);
      });
    }
  }

  Future<void> _submitAndNavigate() async {
    if (_tanggalController.text.isEmpty ||
        _file == null ||
        _nisController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mohon lengkapi NIS, tanggal, dan dokumen.')),
      );
      return;
    }

    try {
      final response = await _viewModel.submitSurat(
        nis: _nisController.text,
        keterangan: _selectedJenis,
        uraian: _uraianController.text,
        tanggalAbsensi: _tanggalController.text,
        filePath: _file!.path,
      );

      if (response.message == "success") {
        if (!mounted) return;
        Navigator.pushNamed(
          context,
          '/ringkasan-pengajuan',
          arguments: {
            'tanggal': _tanggalController.text,
            'jenisIzin': _selectedJenis,
            'keterangan': _uraianController.text,
            'dokumen': _file,
          },
        );
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: Text("Berhasil dikirim"),
              content: Text("Surat Pengajuan izin Berhasil dikirim! "),
              actions: [
                TextButton(
                  onPressed: () => '/ringkasan-pengajuan',
                  child: Text("Lihat Ringkasan"),
                ),
              ],
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomOrangTuaDrawer(selectedMenu: currentMenu),
      key: _scaffoldKey,
      appBar: CustomAppBarOrangTua(
        onMenuPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("NIS Siswa *"),
            const SizedBox(height: 6),
            TextField(
              controller: _nisController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Masukkan NIS Siswa",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),

            const Text("Tanggal Izin *"),
            const SizedBox(height: 6),
            TextField(
              controller: _tanggalController,
              readOnly: true,
              onTap: _pickTanggalIzin,
              decoration: InputDecoration(
                hintText: "yy-MM-dd",
                suffixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),

            const Text("Jenis Izin *"),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              value:
                  ['s', 'i'].contains(_selectedJenis) ? _selectedJenis : null,
              items: const [
                DropdownMenuItem(value: 's', child: Text('Sakit')),
                DropdownMenuItem(value: 'i', child: Text('Izin')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedJenis = value!;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 16),

            const Text("Uraian"),
            const SizedBox(height: 6),
            TextField(
              controller: _uraianController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Contoh: Anak saya sedang ada acara keluarga",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),

            const Text("Dokumen Pendukung *"),
            const SizedBox(height: 6),
            ElevatedButton.icon(
              onPressed: _pickDokumen,
              icon: const Icon(Icons.upload_file),
              label: Text(
                _file != null
                    ? "File Dipilih: ${_file!.path.split('/').last}"
                    : "Unggah Dokumen",
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                side: BorderSide(color: Colors.grey),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitAndNavigate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Lihat Ringkasan",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
