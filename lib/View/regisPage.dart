// Halaman awal registrasi orang tua (input NIS dan status ortu)
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sina_mobile/View/OrangTua/TokenVerifikasiPage.dart';
import 'package:sina_mobile/View/loginPage.dart';
import 'package:sina_mobile/ViewModel/OrangTua/RegisterViewModel.dart';

class RegisPage extends StatefulWidget {
  const RegisPage({super.key});

  @override
  State<RegisPage> createState() => _RegisPageState();
}

class _RegisPageState extends State<RegisPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nisController = TextEditingController();
  String? selectedKategori;
  final List<String> kategoriList = ['Ibu', 'Ayah', 'Wali'];

  @override
  Widget build(BuildContext context) {
    final registerViewModel = Provider.of<RegisterViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 30),
                Image.asset('lib/asset/image/loginLogo.png', height: 150),
                const SizedBox(height: 20),
                const Text(
                  'Register',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Masukkan NIS siswa untuk membuat akun orang tua',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // Status Ortu
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Daftar Sebagai',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  value: selectedKategori,
                  onChanged:
                      (value) => setState(() => selectedKategori = value),
                  validator:
                      (value) =>
                          value == null
                              ? 'Pilih kategori terlebih dahulu'
                              : null,
                  items:
                      kategoriList.map((kategori) {
                        return DropdownMenuItem<String>(
                          value: kategori.toLowerCase(),
                          child: Text(kategori),
                        );
                      }).toList(),
                ),
                const SizedBox(height: 16),

                // NIS
                TextFormField(
                  controller: _nisController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'NIS',
                    hintText: 'Masukkan NIS Siswa',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'NIS wajib diisi'
                              : null,
                ),
                const SizedBox(height: 30),

                // Tombol Lanjutkan
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed:
                        registerViewModel.isLoading
                            ? null
                            : () async {
                              if (_formKey.currentState!.validate()) {
                                await registerViewModel.startRegistration(
                                  _nisController.text,
                                  selectedKategori!,
                                );

                                if (registerViewModel.errorMessage == null &&
                                    registerViewModel.registerData != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) => TokenVerifikasiPage(
                                            nis: _nisController.text,
                                            statusOrtu: selectedKategori!,
                                            registerData:
                                                registerViewModel.registerData,
                                          ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        registerViewModel.errorMessage ??
                                            'Gagal',
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F66F8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child:
                        registerViewModel.isLoading
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                            : const Text(
                              'Lanjutkan',
                              style: TextStyle(color: Colors.white),
                            ),
                  ),
                ),
                const SizedBox(height: 16),

                // Sudah punya akun?
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                    );
                  },
                  child: const Text(
                    'Sudah punya akun? Login',
                    style: TextStyle(
                      color: Color(0xFF2F66F8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
