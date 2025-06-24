import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/Guru/AbsensiInput.dart';
import 'package:sina_mobile/View/Component/CustomAppBar.dart';
import 'package:sina_mobile/View/Component/CustomDropdown.dart';
import 'package:sina_mobile/View/Component/CustomSnackbar.dart';
import 'package:sina_mobile/View/Component/Custom_drawer.dart';
import 'package:sina_mobile/View/Component/ItemAbsensi.dart';
import 'package:sina_mobile/View/Component/RegularButton.dart';
import 'package:sina_mobile/View/Component/TitleAbsensi.dart';
import 'package:sina_mobile/View/Component/TitleBar.dart';
import 'package:sina_mobile/ViewModel/Guru/AbsensiGuruViewModel.dart';
import 'package:provider/provider.dart';

class Absensi extends StatefulWidget{
  @override
  State<Absensi> createState() => _AbsensiState();
}

class _AbsensiState extends State<Absensi> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String currentMenu = 'absensi';
  late AbsensiGuruViewModel vm;
  String? selectedMapelId;

  //list absensi siswa
  List<AbsensiInput> absensiList = [];

  String? selectedJadwalId;


  @override
  void initState() {
    super.initState();
    vm = Provider.of<AbsensiGuruViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      vm.fetchJadwal();
    });
  }


  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AbsensiGuruViewModel>(context);

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton<String>(
                    value: selectedMapelId,
                    items: vm.jadwalitem!.map((item) {
                      return DropdownMenuItem<String>(
                        value: item.mapelId,
                        child: Text("${item.namaMapel} / ${item.namaKelas}"),
                      );
                    }).toList(),
                      onChanged: (newValue) async {
                        if (newValue != null) {
                          setState(() {
                            selectedMapelId = newValue;
                            // Cari item yang dipilih
                            final selectedItem = vm.jadwalitem!.firstWhere((item) => item.mapelId == newValue);
                            selectedJadwalId = selectedItem.jadwalId;
                          });

                          // Ambil siswa berdasarkan mapelId
                          await vm.fetchSiswa(newValue);

                          // Update list absensi
                          setState(() {
                            absensiList = vm.absensisiswa!.map((siswa) {
                              return AbsensiInput(
                                krsId: siswa.krsId,
                                nama: siswa.nama,
                                status: 'H',
                              );
                            }).toList();
                          });
                        }
                      }
                  ),
                  Container(
                    width: 120,
                    height: 32,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.date_range_outlined),
                          Text("14 Jan 2025")
                        ],
                      ),
                    )
                  )
                ],
              ),
              SizedBox(height: 10,),
              TitleAbsensi(),
              SizedBox(height: 10),
              vm.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : vm.absensisiswa == null
                  ? Text("Pilih mapel untuk menampilkan siswa")
                  : Column(
                children: absensiList
                    .map((input) => ItemAbsensi(input: input))
                    .toList(),
              ),
              SizedBox(height: 50,),
              RegularButton(
                  onTap: () async {
                    // Cek data
                    for (var absensi in absensiList) {
                      print('KRS ID: ${absensi.krsId}, Status: ${absensi.status}');
                    }

                    //jadwalID
                    final jadwalId = selectedJadwalId;

                    // Siapkan payload
                    final payload = {
                      'absensiData': absensiList.map((item) => {
                        'krs_id': item.krsId,
                        'keterangan': item.status,
                        'uraian': "",
                      }).toList(),
                    };

                    try {
                      await vm.kirimAbsensi(payload, jadwalId ?? '');
                      CustomSnackbar.showSuccess(context, "Berhasil Absensi Siswa");
                    } catch (e) {
                      print('Gagal absensi : $e');
                      CustomSnackbar.showError(context, "Gagal Absensi Siswa");
                    }

                    print(payload);


                  },
                  judul: "Simpan")
            ],
          ),
        ),
      ),
    );
  }
}