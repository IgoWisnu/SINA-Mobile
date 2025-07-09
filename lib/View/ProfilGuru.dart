import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/Guru/Guru.dart';
import 'package:sina_mobile/View/Component/CustomAppBar.dart';
import 'package:sina_mobile/View/Component/CustomDatePicker.dart';
import 'package:sina_mobile/View/Component/CustomSnackbar.dart';
import 'package:sina_mobile/View/Component/CustomTextArea.dart';
import 'package:sina_mobile/View/Component/CustomTextField.dart';
import 'package:sina_mobile/View/Component/Custom_drawer.dart';
import 'package:sina_mobile/View/Component/Murid/CustomMuridDrawer.dart';
import 'package:sina_mobile/View/Component/RegularButton.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';
import 'package:sina_mobile/View/UbahPassword.dart';
import 'package:sina_mobile/ViewModel/Guru/ProfilGuruViewModel.dart';
import 'package:provider/provider.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:device_info_plus/device_info_plus.dart';


class ProfilGuru extends StatefulWidget{

  @override
  State<ProfilGuru> createState() => _ProfilGuruState();
}

class _ProfilGuruState extends State<ProfilGuru> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String currentMenu = 'profil_guru';

  final picker = ImagePicker();
  File? _profileImage;

  // Controller untuk semua input
  final nipController = TextEditingController();
  final namaController = TextEditingController();
  final tempatLahirController = TextEditingController();
  final tanggalLahirController = TextEditingController();
  final nomorTeleponController = TextEditingController();
  final alamatController = TextEditingController();
  final agamaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = Provider.of<ProfilGuruViewModel>(context, listen: false);
      print("📢 Memanggil fetchBiodataGuru...");
      vm.fetchBiodataGuru();
    });
  }

  void populateControllersIfEmpty(Guru guru) {
    if (nipController.text.isEmpty) {
      nipController.text = guru.nip;
      namaController.text = guru.namaGuru;
      tempatLahirController.text = guru.tempatLahirGuru;
      tanggalLahirController.text = guru.tanggalLahirGuru.toIso8601String().split('T')[0];
      nomorTeleponController.text = guru.noTelepon;
      alamatController.text = guru.alamat;
      selectedAgama = 'Hindu';
    }
  }

  final List<String> agamaList = [
    'Islam',
    'Kristen',
    'Katolik',
    'Hindu',
    'Buddha',
    'Konghucu',
  ];

  String selectedAgama = 'Hindu'; // nilai default/dummy

  Future<void> _pickImage() async {
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    final sdkInt = androidInfo.version.sdkInt;

    Permission permission;

    if (Platform.isAndroid) {
      if (sdkInt >= 33) {
        permission = Permission.mediaLibrary; // Android 13+
      } else {
        permission = Permission.storage; // Android < 13
      }
    } else {
      permission = Permission.photos; // iOS
    }

    final status = await permission.request();

    if (status.isGranted) {
      final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picked != null) {
        setState(() {
          _profileImage = File(picked.path);
        });
      }
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Izin galeri ditolak permanen. Buka pengaturan.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Akses galeri ditolak')),
      );
    }
  }

  Future<void> _updateBiodata() async {
    final vm = Provider.of<ProfilGuruViewModel>(context, listen: false);

    // Validasi minimal (opsional, tambahkan validasi lain jika diperlukan)
    if (namaController.text.isEmpty || tempatLahirController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Mohon lengkapi data terlebih dahulu.")),
      );
      return;
    }

    try {
      // Buat objek Guru yang sudah diperbarui
      Guru updated = Guru(
        userId: vm.guru!.userId,
        createdAt: vm.guru!.createdAt,
        nip: vm.guru!.nip,
        namaGuru: vm.guru!.namaGuru,
        tempatLahirGuru: tempatLahirController.text,
        tanggalLahirGuru: DateTime.parse(tanggalLahirController.text),
        alamat: alamatController.text,
        fotoProfil: vm.guru!.fotoProfil,
        noTelepon: nomorTeleponController.text,
        agamaGuru: selectedAgama,
        jenisKelaminGuru: vm.guru!.jenisKelaminGuru,
      );

      await vm.updateProfilGuru(updated, imageFile: _profileImage);
      await vm.fetchBiodataGuru();

      //set image from network
      setState(() {
        _profileImage = null;
      });

      //Unfocus semua field
      FocusScope.of(context).unfocus();


      CustomSnackbar.showSuccess(context, "Berhasil Memperbaharui Profil");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal memperbarui profil: $e")),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    String baseImageUrl = 'http://sina.pnb.ac.id:3000/Upload/profile_image/';

    // TODO: implement build
    return Consumer<ProfilGuruViewModel>(
        builder: (context, vm, _) {
          final guru = vm.guru;
          String? fotoProfil = guru?.fotoProfil; // Misalnya: "12345.jpg"

          String? _networkImageUrl = fotoProfil != null ? '$baseImageUrl$fotoProfil' : null;

          if (guru != null) {
            populateControllersIfEmpty(guru);
          }

          return Scaffold(
            key: _scaffoldKey, // ← INI YANG BELUM ADA
            drawer: CustomDrawer(
              selectedMenu: currentMenu,
            ),
            appBar: CustomAppBar(
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
                    SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.primary,
                      ),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Card(
                              color: AppColors.blueDisable,
                              elevation: 4,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    if (guru?.nip != null && guru!.nip.isNotEmpty)
                                      BarcodeWidget(
                                        barcode: Barcode.qrCode(), // ✅ QR Code seperti QRIS
                                        data: guru.nip,
                                        width: 150,
                                        height: 150,
                                        drawText: false, // QRIS biasanya tidak menampilkan teks
                                      )
                                    else
                                      Text("NIS tidak tersedia"),
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
                                    backgroundImage: _profileImage != null
                                        ? FileImage(_profileImage!)
                                        : (_networkImageUrl != null
                                        ? NetworkImage(_networkImageUrl)
                                        : null),
                                    child: _profileImage == null && _networkImageUrl == null
                                        ? const Icon(Icons.person, size: 50, color: Colors.grey)
                                        : null,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      print("Tombol edit ditekan");
                                      _pickImage();
                                    },
                                    icon: const Icon(
                                        Icons.camera_alt, color: Colors.blue),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text("NIP", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                    SizedBox(height: 5,),
                    CustomTextField(controller: nipController, hintText: 'ssaas', enabled: false,),
                    SizedBox(height: 10,),
                    Text("Nama Lengkap", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                    SizedBox(height: 5,),
                    CustomTextField(controller: namaController, hintText: 'ssaas', enabled: false,),
                    SizedBox(height: 10,),
                    Text("Tempat Lahir", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                    SizedBox(height: 5,),
                    CustomTextField(controller: tempatLahirController, hintText: 'ssaas',),
                    SizedBox(height: 10,),
                    Text("Tanggal Lahir", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                    SizedBox(height: 5,),
                    CustomDatePicker(controller: tanggalLahirController, ),
                    SizedBox(height: 10,),
                    Text("Nomor Telepon", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                    SizedBox(height: 5,),
                    CustomTextField(controller: nomorTeleponController, ),
                    SizedBox(height: 10,),
                    Text("Alamat", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                    SizedBox(height: 5,),
                    CustomTextArea(controller: alamatController, hintText: 'ssaas',),
                    SizedBox(height: 10,),
                    Text("Agama", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                    SizedBox(height: 5,),
                    DropdownButtonFormField<String>(
                      value: selectedAgama,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      ),
                      items: agamaList.map((agama) {
                        return DropdownMenuItem<String>(
                          value: agama,
                          child: Text(agama),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedAgama = value!;
                        });
                      },
                      validator: (value) =>
                      value == null || value.isEmpty ? 'Agama tidak boleh kosong' : null,
                    ),
                    SizedBox(height: 20,),
                    RegularButton(onTap: (){
                      Navigator.push(
                          context,
                        MaterialPageRoute(builder: (context) => UbahPassword())
                      );
                    }, judul: "Ubah Password"),
                    SizedBox(height: 10,),
                    RegularButton(onTap: _updateBiodata, judul: "Perbarui Profil"),
                    SizedBox(height: 20,)
                  ],
                ),
              ),
            ),
          );

        }
    );
  }
}