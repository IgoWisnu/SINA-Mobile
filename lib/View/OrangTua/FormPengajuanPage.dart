import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';

class FormPengajuanPage extends StatefulWidget {
  @override
  _FormPengajuanPageState createState() => _FormPengajuanPageState();
}

class _FormPengajuanPageState extends State<FormPengajuanPage> {
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _keteranganController = TextEditingController();
  String _selectedJenis = 'Sakit';
  File? _file;

  Future<void> _pickTanggalIzin() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      _tanggalController.text = DateFormat('dd/MM/yyyy').format(picked);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Nama Siswa"),
            const SizedBox(height: 6),
            TextField(
              enabled: false,
              decoration: InputDecoration(
                hintText: "Stefanus Bambang N. Sapioper",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[300],
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
                hintText: "dd/mm/yyyy",
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
              value: _selectedJenis,
              items:
                  ["Sakit", "Izin Pribadi", "Izin Keluarga"]
                      .map((e) => DropdownMenuItem(child: Text(e), value: e))
                      .toList(),
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

            const Text("Keterangan"),
            const SizedBox(height: 6),
            TextField(
              controller: _keteranganController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Type here...",
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
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/ringkasan-pengajuan',
                    arguments: {
                      'tanggal': _tanggalController.text,
                      'jenisIzin': _selectedJenis,
                      'keterangan': _keteranganController.text,
                      'dokumen': _file,
                    },
                  );
                },
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
