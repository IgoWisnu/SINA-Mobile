import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/CustomTextField.dart';
import 'package:sina_mobile/View/Component/RegularButton.dart';
import 'package:sina_mobile/View/Component/TitleBarLine.dart';
import 'package:sina_mobile/ViewModel/Guru/ProfilGuruViewModel.dart';
import 'package:provider/provider.dart';

class UbahPassword extends StatefulWidget{
  @override
  State<UbahPassword> createState() => _UbahPasswordState();
}

class _UbahPasswordState extends State<UbahPassword> {

  final _pwLamaController = TextEditingController();
  final _pwBaruController = TextEditingController();
  final _konfirmasiPwController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _simpanPassword() async {
    if (!_formKey.currentState!.validate()) return;

    final vm = Provider.of<ProfilGuruViewModel>(context, listen: false);
    final pwLama = _pwLamaController.text.trim();
    final pwBaru = _pwBaruController.text.trim();

    try {
      await vm.updatePassword(pwLama, pwBaru);

      if (vm.error == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password berhasil diubah')));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal: ${vm.error}')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Terjadi kesalahan: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ProfilGuruViewModel>(context);

    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleBarLine(judul: 'Ubah Password'),
              SizedBox(height: 20),

              Text('Password lama', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              TextFormField(
                controller: _pwLamaController,
                obscureText: true,
                decoration: InputDecoration(border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? 'Password lama wajib diisi' : null,
              ),

              SizedBox(height: 20),
              Text('Password baru', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              TextFormField(
                controller: _pwBaruController,
                obscureText: true,
                decoration: InputDecoration(border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Password baru wajib diisi';
                  if (value.length < 6) return 'Minimal 6 karakter';
                  return null;
                },
              ),

              SizedBox(height: 20),
              Text('Konfirmasi Password', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              TextFormField(
                controller: _konfirmasiPwController,
                obscureText: true,
                decoration: InputDecoration(border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Konfirmasi password wajib diisi';
                  if (value != _pwBaruController.text) return 'Password tidak cocok';
                  return null;
                },
              ),

              SizedBox(height: 30),
              vm.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : RegularButton(onTap: _simpanPassword, judul: 'Simpan'),
            ],
          ),
        ),
      ),
    );
  }
}