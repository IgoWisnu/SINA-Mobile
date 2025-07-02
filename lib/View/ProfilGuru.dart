import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/CustomAppBar.dart';
import 'package:sina_mobile/View/Component/CustomDatePicker.dart';
import 'package:sina_mobile/View/Component/CustomTextArea.dart';
import 'package:sina_mobile/View/Component/CustomTextField.dart';
import 'package:sina_mobile/View/Component/Custom_drawer.dart';
import 'package:sina_mobile/View/Component/Murid/CustomMuridDrawer.dart';
import 'package:sina_mobile/View/Component/RegularButton.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';


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

    // Data demo (dummy)
    nipController.text = "202312345";
    namaController.text = "I Gede Igo Wisnu Wardana";
    tempatLahirController.text = "Denpasar";
    tanggalLahirController.text = "2002-09-15";
    nomorTeleponController.text = "081234567890";
    alamatController.text = "Jl. Merpati No. 12, Denpasar";
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
    // TODO: implement build
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
                width: double.infinity,
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : null,
                      child: _profileImage == null
                          ? const Icon(Icons.person, size: 50, color: Colors.grey)
                          : null,
                    ),
                    IconButton(
                      onPressed: () {
                        print("Tombol edit ditekan");
                        _pickImage();
                      },
                      icon: const Icon(Icons.camera_alt, color: Colors.blue),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Text("NIP", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              SizedBox(height: 5,),
              CustomTextField(controller: nipController, hintText: 'ssaas',),
              SizedBox(height: 10,),
              Text("Nama Lengkap", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              SizedBox(height: 5,),
              CustomTextField(controller: namaController, hintText: 'ssaas',),
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
              CustomDatePicker(controller: nomorTeleponController, ),
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
              RegularButton(onTap: (){}, judul: "Ubah Password"),
              SizedBox(height: 10,),
              RegularButton(onTap: (){}, judul: "Perbarui Profil"),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}