import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/CustomDatePicker.dart';
import 'package:sina_mobile/View/Component/CustomTextArea.dart';
import 'package:sina_mobile/View/Component/CustomTextField.dart';
import 'package:sina_mobile/View/Component/OrangTua/CustomAppBarOrangTua.dart';
import 'package:sina_mobile/View/Component/OrangTua/CustomOrangTuaDrawer.dart';
import 'package:sina_mobile/View/Component/RegularButton.dart';
import 'package:sina_mobile/View/OrangTua/DetailPengumumanPage.dart';
import 'package:sina_mobile/ViewModel/OrangTua/ProfilOrtuViewModel.dart';

class ProfilOrangTuaPage extends StatefulWidget {
  const ProfilOrangTuaPage({Key? key}) : super(key: key);

  @override
  State<ProfilOrangTuaPage> createState() => _ProfilOrangTuaPageState();
}

class _ProfilOrangTuaPageState extends State<ProfilOrangTuaPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String currentMenu = 'profil_ortu';

  final picker = ImagePicker();
  File? _profileImage;

  // Controller untuk semua input
  final nikController = TextEditingController();
  final namaController = TextEditingController();
  final imeiController = TextEditingController();
  final alamatController = TextEditingController();
  final status_ortuController = TextEditingController();
  final pekerjaanController = TextEditingController();
  final tempat_lahir_ortuController = TextEditingController();
  final tanggal_lahir_ortuController = TextEditingController();
  final noTelpController = TextEditingController();

  void initState() {
    super.initState();

    Future.microtask(() async {
      final vm = Provider.of<ProfilOrtuViewModel>(context, listen: false);
      await vm.fetchBiodataOrtu();

      final ortu = vm.ortu;
      if (ortu != null) {
        setState(() {
          nikController.text = ortu.nik;
          namaController.text = ortu.nama_ortu;
          imeiController.text = ortu.imei;
          alamatController.text = ortu.alamat;
          status_ortuController.text = ortu.status_ortu;
          pekerjaanController.text = ortu.pekerjaan;
          tempat_lahir_ortuController.text = ortu.tempat_lahir_ortu;
          tanggal_lahir_ortuController.text =
              ortu.tanggal_lahir_ortu.toIso8601String().split('T')[0];
          noTelpController.text = ortu.no_telepon;
        });
      }
    });
  }

  @override
  Future<void> _pickImage() async {
    var status = await Permission.photos.request();

    if (status.isGranted) {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path);
        });
      }
    } else {
      // Opsional: tampilkan snackbar atau dialog
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Akses galeri ditolak')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfilOrtuViewModel>(
      builder: (context, vm, _) {
        final ortu = vm.ortu;

        if (ortu != null && nikController.text.isEmpty) {
          // Pastikan hanya set saat controller kosong agar tidak overwrite manual user input
          nikController.text = ortu.nik;
          namaController.text = ortu.nama_ortu;
          imeiController.text = ortu.imei;
          alamatController.text = ortu.alamat;
          status_ortuController.text = ortu.status_ortu;
          pekerjaanController.text = ortu.pekerjaan;
          tempat_lahir_ortuController.text = ortu.tempat_lahir_ortu;
          tanggal_lahir_ortuController.text =
              ortu.tanggal_lahir_ortu.toIso8601String().split('T')[0];
          noTelpController.text = ortu.no_telepon;
        }

        return Scaffold(
          drawer: CustomOrangTuaDrawer(selectedMenu: currentMenu),
          key: _scaffoldKey,
          appBar: CustomAppBarOrangTua(
            onMenuPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey[300],
                          backgroundImage:
                              _profileImage != null
                                  ? FileImage(_profileImage!)
                                  : null,
                          child:
                              _profileImage == null
                                  ? const Icon(
                                    Icons.person,
                                    size: 50,
                                    color: Colors.grey,
                                  )
                                  : null,
                        ),
                        IconButton(
                          onPressed: () {
                            print("Tombol edit ditekan");
                            _pickImage();
                          },
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "NIK",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  CustomTextField(controller: nikController, enabled: false),
                  SizedBox(height: 10),
                  Text(
                    "Nama Lengkap",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  CustomTextField(controller: namaController, enabled: false),
                  SizedBox(height: 10),
                  Text(
                    "Tempat Lahir",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  CustomTextField(
                    controller: tempat_lahir_ortuController,
                    hintText: 'Masukkan tempat lahir',
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Tanggal Lahir",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  CustomDatePicker(controller: tanggal_lahir_ortuController),
                  SizedBox(height: 10),
                  Text(
                    "Nomor Telepon",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  CustomTextField(controller: noTelpController),
                  SizedBox(height: 10),
                  Text(
                    "Alamat",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  CustomTextArea(
                    controller: alamatController,
                    hintText: 'Masukkan alamat lengkap',
                  ),
                  Text(
                    "Pekerjaan",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  CustomTextField(
                    controller: pekerjaanController,
                    enabled: false,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Status Orang Tua",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  CustomTextField(
                    controller: status_ortuController,
                    enabled: false,
                  ),

                  SizedBox(height: 10),

                  SizedBox(height: 20),
                  RegularButton(onTap: () {}, judul: "Ubah Password"),
                  SizedBox(height: 10),
                  RegularButton(onTap: () {}, judul: "Perbarui Profil"),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
