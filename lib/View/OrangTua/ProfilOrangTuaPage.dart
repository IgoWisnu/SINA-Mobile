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
      permissionStatus = await Permission.photos.request();
      if (permissionStatus.isDenied) {
        permissionStatus = await Permission.storage.request();
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
        await vm.fetchBiodataOrtu();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Akses galeri ditolak'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.red[400],
        ),
      );
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
                  ? const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF347AF0),
                      ),
                    ),
                  )
                  : Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.grey[50]!, Colors.white],
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),

                          // --- Header QR dan Foto ---
                          Material(
                            elevation: 4,
                            borderRadius: BorderRadius.circular(16),
                            shadowColor: Colors.blue.withOpacity(0.2),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    const Color(0xFF347AF0),
                                    Colors.blue[700]!,
                                  ],
                                ),
                              ),
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // QR Code
                                  Material(
                                    elevation: 6,
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        children: [
                                          const Text(
                                            'ID Orang Tua',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          nikController.text.isNotEmpty
                                              ? BarcodeWidget(
                                                barcode: Barcode.qrCode(),
                                                data: nikController.text,
                                                width: 120,
                                                height: 120,
                                                drawText: false,
                                                color: Colors.blue,
                                              )
                                              : Container(
                                                width: 120,
                                                height: 120,
                                                alignment: Alignment.center,
                                                child: const Text(
                                                  "NIK tidak tersedia",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // Profile Picture
                                  Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 3,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.2,
                                              ),
                                              blurRadius: 8,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: CircleAvatar(
                                          radius: 50,
                                          backgroundColor: Colors.grey[200],
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
                                                      (_networkImageUrl ==
                                                              null ||
                                                          _networkImageUrl
                                                              .isEmpty)
                                                  ? const Icon(
                                                    Icons.person,
                                                    size: 50,
                                                    color: Colors.grey,
                                                  )
                                                  : null,
                                        ),
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue,
                                        ),
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.camera_alt,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          onPressed: _pickImage,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Form Fields
                          _buildSectionTitle('Informasi Pribadi'),
                          _buildLabel("NIK"),
                          CustomTextField(
                            controller: nikController,
                            enabled: false,
                            prefixIcon: Icons.credit_card,
                          ),
                          _buildSpacer(),

                          _buildLabel("Nama Lengkap"),
                          CustomTextField(
                            controller: namaController,
                            enabled: false,
                            prefixIcon: Icons.person,
                          ),
                          _buildSpacer(),

                          _buildLabel("Tempat Lahir"),
                          CustomTextField(
                            controller: tempat_lahir_ortuController,
                            hintText: 'Masukkan tempat lahir',
                            prefixIcon: Icons.place,
                          ),
                          _buildSpacer(),

                          _buildLabel("Tanggal Lahir"),
                          CustomDatePicker(
                            controller: tanggal_lahir_ortuController,
                          ),
                          _buildSpacer(),

                          _buildLabel("Nomor Telepon"),
                          CustomTextField(
                            controller: noTelpController,
                            prefixIcon: Icons.phone,
                          ),
                          _buildSpacer(),

                          _buildSectionTitle('Informasi Tambahan'),
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
                            prefixIcon: Icons.work,
                          ),
                          _buildSpacer(),

                          _buildLabel("Status Orang Tua"),
                          CustomTextField(
                            controller: status_ortuController,
                            enabled: false,
                            prefixIcon: Icons.family_restroom,
                          ),

                          const SizedBox(height: 24),
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
                          const SizedBox(height: 12),
                          RegularButton(
                            onTap: () async {
                              final vm = Provider.of<ProfilOrtuViewModel>(
                                context,
                                listen: false,
                              );
                              try {
                                await vm.updateProfilOrtu(
                                  tempatLahir: tempat_lahir_ortuController.text,
                                  tanggalLahir:
                                      tanggal_lahir_ortuController.text,
                                  alamat: alamatController.text,
                                  noTelepon: noTelpController.text,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      "Profil berhasil diperbarui",
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor: Colors.green[400],
                                  ),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Gagal memperbarui: $e"),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor: Colors.red[400],
                                  ),
                                );
                              }
                            },
                            judul: "Simpan Perubahan Profil",
                          ),

                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
        );
      },
    );
  }

  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6, left: 4),
    child: Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 15,
        color: Colors.grey[700],
      ),
    ),
  );

  Widget _buildSectionTitle(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 12, top: 8),
    child: Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Color(0xFF347AF0),
      ),
    ),
  );

  Widget _buildSpacer() => const SizedBox(height: 14);
}
