import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/Model/OrangTua/Siswa.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/OrangTua/CustomOrangTuaDrawer.dart';
import 'package:sina_mobile/View/OrangTua/RiwayatPengajuanPage.dart';
import 'package:sina_mobile/ViewModel/OrangTua/AjukanSuratViewModel.dart';
import 'package:sina_mobile/service/api/ApiServisOrangTua.dart';
import 'package:sina_mobile/service/repository/OrangTua/AjukanSuratRepository.dart';
import 'package:sina_mobile/service/repository/OrangTua/DaftarSiswaRepository.dart';

class FormPengajuanPage extends StatefulWidget {
  const FormPengajuanPage({super.key});

  @override
  State<FormPengajuanPage> createState() => _FormPengajuanPageState();
}

class _FormPengajuanPageState extends State<FormPengajuanPage> {
  final TextEditingController _uraianController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _selectedJenis = 's';
  File? _file;

  List<Siswa> siswaList = [];
  Siswa? selectedSiswa;

  @override
  void initState() {
    super.initState();
    fetchSiswaList();
  }

  @override
  void dispose() {
    _uraianController.dispose();
    _tanggalController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> fetchSiswaList() async {
    try {
      final repo = DaftarSiswaRepository(ApiServiceOrangTua());
      final data = await repo.fetchSiswaByOrtu();
      setState(() {
        siswaList = data;
        if (data.isNotEmpty) selectedSiswa = data.first;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal memuat daftar siswa: $e")),
        );
      }
    }
  }

  Future<void> _pickTanggalIzin() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      // Pastikan tanggal dalam format yyyy-MM-dd tanpa jam
      final formatted = DateFormat(
        'yyyy-MM-dd',
      ).format(DateTime(picked.year, picked.month, picked.day));
      setState(() {
        _tanggalController.text = formatted;
      });
    }
  }

  Future<void> _pickDokumen() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
      );
      if (result != null && result.files.single.path != null) {
        final fileSize = result.files.single.size;
        if (fileSize > 5 * 1024 * 1024) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Ukuran file maksimal 5MB")),
          );
          return;
        }
        setState(() {
          _file = File(result.files.single.path!);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Gagal memilih file: $e")));
    }
  }

  void _showKonfirmasiDialog() {
    if (!_formKey.currentState!.validate()) return;
    if (selectedSiswa == null || _file == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lengkapi semua isian terlebih dahulu.")),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Konfirmasi Password"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Masukkan password untuk mengirim pengajuan:"),
              const SizedBox(height: 12),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                if (_passwordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Password tidak boleh kosong"),
                    ),
                  );
                  return;
                }
                Navigator.pop(context);
                _submitPengajuan();
              },
              child: const Text("Kirim"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _submitPengajuan() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    try {
      final vm = Provider.of<AjukanSuratViewModel>(context, listen: false);
      final response = await vm.submitSurat(
        nis: selectedSiswa!.nis,
        keterangan: _selectedJenis,
        uraian: _uraianController.text,
        tanggalAbsensi: _tanggalController.text,
        filePath: _file!.path,
        password: _passwordController.text,
      );

      if (response.data != null && mounted) {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder:
              (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: const Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green),
                    SizedBox(width: 8),
                    Text("Berhasil"),
                  ],
                ),
                content: const Text("Surat berhasil dikirim!"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      navigator.pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const RiwayatPengajuanPage(),
                        ),
                      );
                    },
                    child: const Text("OK"),
                  ),
                ],
              ),
        );
      } else {
        throw Exception("Data kosong dari response.");
      }
    } catch (e) {
      if (mounted) {
        scaffoldMessenger.showSnackBar(
          SnackBar(content: Text("Gagal mengirim pengajuan: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomOrangTuaDrawer(selectedMenu: 'pengajuan'),
      appBar: CustomAppBarNoDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Formulir Pengajuan Surat Izin',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              const Text("Pilih Anak *"),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Siswa>(
                    isExpanded: true,
                    value: selectedSiswa,
                    hint: const Text("Pilih Siswa"),
                    items:
                        siswaList.map((siswa) {
                          return DropdownMenuItem<Siswa>(
                            value: siswa,
                            child: Text(siswa.nama),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() => selectedSiswa = value);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text("Tanggal Izin *"),
              const SizedBox(height: 6),
              TextFormField(
                controller: _tanggalController,
                readOnly: true,
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Harap pilih tanggal izin'
                            : null,
                onTap: _pickTanggalIzin,
                decoration: InputDecoration(
                  hintText: "yy-MM-dd",
                  suffixIcon: const Icon(Icons.calendar_today),
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
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Harap pilih jenis izin'
                            : null,
                items: const [
                  DropdownMenuItem(value: 's', child: Text('Sakit')),
                  DropdownMenuItem(value: 'i', child: Text('Izin')),
                ],
                onChanged: (value) => setState(() => _selectedJenis = value!),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text("Uraian *"),
              const SizedBox(height: 6),
              TextFormField(
                controller: _uraianController,
                maxLines: 4,
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Harap isi uraian'
                            : null,
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
                      ? "File: ${_file!.path.split('/').last}"
                      : "Unggah Dokumen",
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  side: const BorderSide(color: Colors.grey),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              if (_file != null) ...[
                const SizedBox(height: 8),
                Text(
                  "Ukuran: ${(_file!.lengthSync() / 1024).toStringAsFixed(2)} KB",
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _showKonfirmasiDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Kirim Pengajuan",
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
      ),
    );
  }
}
