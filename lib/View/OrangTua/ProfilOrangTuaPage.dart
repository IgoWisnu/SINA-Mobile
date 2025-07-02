import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:sina_mobile/View/Component/CustomDatePicker.dart';
import 'package:sina_mobile/View/Component/CustomTextArea.dart';
import 'package:sina_mobile/View/Component/CustomTextField.dart';
import 'package:sina_mobile/View/Component/OrangTua/CustomAppBarOrangTua.dart';
import 'package:sina_mobile/View/Component/OrangTua/CustomOrangTuaDrawer.dart';
import 'package:sina_mobile/View/Component/RegularButton.dart';
import 'package:sina_mobile/View/OrangTua/UpdatePasswordPage.dart';
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

  final nikController = TextEditingController();
  final namaController = TextEditingController();
  final imeiController = TextEditingController();
  final alamatController = TextEditingController();
  final status_ortuController = TextEditingController();
  final pekerjaanController = TextEditingController();
  final tempat_lahir_ortuController = TextEditingController();
  final tanggal_lahir_ortuController = TextEditingController();
  final noTelpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final vm = Provider.of<ProfilOrtuViewModel>(context, listen: false);
      await vm.fetchBiodataOrtu();

      final ortu = vm.ortu;
      if (ortu != null) {
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
    });
  }

  Future<void> _pickImage() async {
    PermissionStatus permissionStatus;

    if (Platform.isAndroid) {
      permissionStatus = await Permission.photos.request(); // Android 13+
      if (permissionStatus.isDenied) {
        permissionStatus = await Permission.storage.request(); // Android <13
      }
    } else {
      permissionStatus = await Permission.photos.request();
    }

    if (permissionStatus.isGranted) {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path);
        });

        final vm = Provider.of<ProfilOrtuViewModel>(context, listen: false);
        await vm.uploadFoto(File(pickedFile.path));
        await vm.fetchBiodataOrtu(); // Refresh data setelah upload
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Akses galeri ditolak')));
    }
  }

  @override
  Widget build(BuildContext context) {
    String baseImageUrl = 'http://sina.pnb.ac.id:3006/Upload/profile_image/';

    return Consumer<ProfilOrtuViewModel>(
      builder: (context, vm, _) {
        final ortu = vm.ortu;
        String? fotoProfil = ortu?.fotoProfil;
        String? _networkImageUrl =
            fotoProfil != null ? '$baseImageUrl$fotoProfil' : null;

        return Scaffold(
          key: _scaffoldKey,
          drawer: CustomOrangTuaDrawer(selectedMenu: currentMenu),
          appBar: CustomAppBarOrangTua(
            onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          body:
              vm.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        // --- Header QR dan Foto ---
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xFF347AF0),
                          ),
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 3,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Card(
                                  color: Colors.blue[100],
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 10),
                                        nikController.text.isNotEmpty
                                            ? BarcodeWidget(
                                              barcode: Barcode.qrCode(),
                                              data: nikController.text,
                                              width: 150,
                                              height: 150,
                                              drawText: false,
                                            )
                                            : const Text("NIK tidak tersedia"),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 100,
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
                                                : (_networkImageUrl != null &&
                                                        _networkImageUrl
                                                            .isNotEmpty
                                                    ? NetworkImage(
                                                      _networkImageUrl,
                                                    )
                                                    : null),
                                        child:
                                            _profileImage == null &&
                                                    (_networkImageUrl == null ||
                                                        _networkImageUrl
                                                            .isEmpty)
                                                ? const Icon(
                                                  Icons.person,
                                                  size: 50,
                                                  color: Colors.grey,
                                                )
                                                : null,
                                      ),

                                      IconButton(
                                        onPressed: _pickImage,
                                        icon: const Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                        _buildLabel("NIK"),
                        CustomTextField(
                          controller: nikController,
                          enabled: false,
                        ),
                        _buildSpacer(),

                        _buildLabel("Nama Lengkap"),
                        CustomTextField(
                          controller: namaController,
                          enabled: false,
                        ),
                        _buildSpacer(),

                        _buildLabel("Tempat Lahir"),
                        CustomTextField(
                          controller: tempat_lahir_ortuController,
                          hintText: 'Masukkan tempat lahir',
                        ),
                        _buildSpacer(),

                        _buildLabel("Tanggal Lahir"),
                        CustomDatePicker(
                          controller: tanggal_lahir_ortuController,
                        ),
                        _buildSpacer(),

                        _buildLabel("Nomor Telepon"),
                        CustomTextField(controller: noTelpController),
                        _buildSpacer(),

                        _buildLabel("Alamat"),
                        CustomTextArea(
                          controller: alamatController,
                          hintText: 'Masukkan alamat lengkap',
                        ),
                        _buildSpacer(),

                        _buildLabel("Pekerjaan"),
                        CustomTextField(
                          controller: pekerjaanController,
                          enabled: false,
                        ),
                        _buildSpacer(),

                        _buildLabel("Status Orang Tua"),
                        CustomTextField(
                          controller: status_ortuController,
                          enabled: false,
                        ),

                        const SizedBox(height: 20),
                        RegularButton(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => UpdatePasswordPage(),
                              ),
                            );
                          },
                          judul: "Ubah Password",
                        ),
                        const SizedBox(height: 10),
                        RegularButton(
                          onTap: () async {
                            final vm = Provider.of<ProfilOrtuViewModel>(
                              context,
                              listen: false,
                            );
                            try {
                              await vm.updateProfilOrtu(
                                tempatLahir: tempat_lahir_ortuController.text,
                                tanggalLahir: tanggal_lahir_ortuController.text,
                                alamat: alamatController.text,
                                noTelepon: noTelpController.text,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Profil berhasil diperbarui"),
                                ),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Gagal memperbarui: $e"),
                                ),
                              );
                            }
                          },
                          judul: "Simpan Perubahan Profil",
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
        );
      },
    );
  }

  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
  );

  Widget _buildSpacer() => const SizedBox(height: 10);
}
