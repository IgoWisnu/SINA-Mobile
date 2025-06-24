import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/CustomAppBar.dart';
import 'package:sina_mobile/View/Component/CustomDatePicker.dart';
import 'package:sina_mobile/View/Component/CustomTextArea.dart';
import 'package:sina_mobile/View/Component/CustomTextField.dart';
import 'package:sina_mobile/View/Component/Murid/CustomMuridDrawer.dart';
import 'package:sina_mobile/View/Component/RegularButton.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';
import 'package:sina_mobile/ViewModel/ProfilViewModel.dart';
import 'package:provider/provider.dart';
import 'package:barcode_widget/barcode_widget.dart';


class ProfilMurid extends StatefulWidget{

  @override
  State<ProfilMurid> createState() => _ProfilMuridState();
}

class _ProfilMuridState extends State<ProfilMurid> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String currentMenu = 'profil_siswa';

  final picker = ImagePicker();
  File? _profileImage;

  // Controller untuk semua input
  final nikController = TextEditingController();
  final nismController = TextEditingController();
  final namaController = TextEditingController();
  final tempatLahirController = TextEditingController();
  final tanggalLahirController = TextEditingController();
  final nomorTeleponController = TextEditingController();
  final alamatController = TextEditingController();
  final agamaController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final vm = Provider.of<ProfilViewModel>(context, listen: false);
      await vm.fetchBiodataSiswa();

      final siswa = vm.siswa;
      if (siswa != null) {
        setState(() {
          nikController.text = siswa.nis;
          nismController.text = siswa.nis; // atau field yang sesuai
          namaController.text = siswa.nama;
          tempatLahirController.text = siswa.tempatLahir;
          tanggalLahirController.text =
          siswa.tanggalLahir.toIso8601String().split('T')[0];
          nomorTeleponController.text = '085729322983';
          alamatController.text = siswa.alamat;
          selectedAgama = 'Hindu';
        });
      }
    });
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Akses galeri ditolak')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    String baseImageUrl = 'http://sina.pnb.ac.id:3001/Upload/profile_image/';

    return Consumer<ProfilViewModel>(
      builder: (context, vm, _) {
        final siswa = vm.siswa;
        String? fotoProfil = siswa?.fotoProfil; // Misalnya: "12345.jpg"

        String? _networkImageUrl = fotoProfil != null ? '$baseImageUrl$fotoProfil' : null;

        if (siswa != null && nikController.text.isEmpty) {
          // Pastikan hanya set saat controller kosong agar tidak overwrite manual user input
          nikController.text = siswa.nis;
          nismController.text = siswa.nis;
          namaController.text = siswa.nama;
          tempatLahirController.text = siswa.tempatLahir;
          tanggalLahirController.text =
          siswa.tanggalLahir.toIso8601String().split('T')[0];
          nomorTeleponController.text = '23132132312';
          alamatController.text = siswa.alamat;
          selectedAgama = 'Hindu';
        }

        // TODO: implement build
        return Scaffold(
          key: _scaffoldKey, // ← INI YANG BELUM ADA
          drawer: CustomMuridDrawer(
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
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.primary,
                    ),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                  if (siswa?.nis != null && siswa!.nis.isNotEmpty)
                                    BarcodeWidget(
                                      barcode: Barcode.qrCode(), // ✅ QR Code seperti QRIS
                                      data: siswa.nis,
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
                  Text("NIS", style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),),
                  SizedBox(height: 5,),
                  CustomTextField(
                    controller: nikController, enabled: false, ),
                  SizedBox(height: 10,),
                  Text("NISN", style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),),
                  SizedBox(height: 5,),
                  CustomTextField(
                    controller: nismController, enabled: false,),
                  SizedBox(height: 10,),
                  Text("Nama Lengkap", style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),),
                  SizedBox(height: 5,),
                  CustomTextField(
                    controller: namaController, enabled: false,),
                  SizedBox(height: 10,),
                  Text("Tempat Lahir", style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),),
                  SizedBox(height: 5,),
                  CustomTextField(
                    controller: tempatLahirController, hintText: 'ssaas',),
                  SizedBox(height: 10,),
                  Text("Tanggal Lahir", style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),),
                  SizedBox(height: 5,),
                  CustomDatePicker(controller: tanggalLahirController,),
                  SizedBox(height: 10,),
                  Text("Nomor Telepon", style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),),
                  SizedBox(height: 5,),
                  CustomTextField(controller: nomorTeleponController,),
                  SizedBox(height: 10,),
                  Text("Alamat", style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),),
                  SizedBox(height: 5,),
                  CustomTextArea(
                    controller: alamatController, hintText: 'ssaas',),
                  SizedBox(height: 10,),
                  Text("Agama", style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),),
                  SizedBox(height: 5,),
                  DropdownButtonFormField<String>(
                    value: selectedAgama,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 12, vertical: 16),
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
                    value == null || value.isEmpty
                        ? 'Agama tidak boleh kosong'
                        : null,
                  ),
                  SizedBox(height: 20,),
                  RegularButton(onTap: () {}, judul: "Ubah Password"),
                  SizedBox(height: 10,),
                  RegularButton(onTap: () {}, judul: "Perbarui Profil"),
                  SizedBox(height: 20,)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}