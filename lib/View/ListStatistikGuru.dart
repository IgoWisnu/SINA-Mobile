import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/Guru/KelasGuru.dart';
import 'package:sina_mobile/View/Component/CustomAppBar.dart';
import 'package:sina_mobile/View/Component/CustomDropdown.dart';
import 'package:sina_mobile/View/Component/CustomFlexDropdown.dart';
import 'package:sina_mobile/View/Component/Custom_drawer.dart';
import 'package:sina_mobile/View/Component/ItemStatistikSiswa.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';
import 'package:sina_mobile/View/Murid/StatistikSiswa.dart';
import 'package:sina_mobile/View/StatistikGuruDetail.dart';
import 'package:sina_mobile/ViewModel/Guru/StatistikGuruViewModel.dart';
import 'package:provider/provider.dart';

class ListStatistikGuru extends StatefulWidget{

  @override
  State<ListStatistikGuru> createState() => _ListStatistikGuruState();
}

class _ListStatistikGuruState extends State<ListStatistikGuru> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String currentMenu = 'statistik';
  KelasItem? selectedKelas;

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<StatistikGuruViewModel>(context, listen: false);
    viewModel.fetchKelas();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<StatistikGuruViewModel>(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(selectedMenu: currentMenu),
      appBar: CustomAppBar(
        onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            // Dropdown Kelas
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Statistik Nilai Siswa", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                viewModel.listmapel == null
                    ? CircularProgressIndicator()
                    : CustomFlexDropdown<KelasItem>(
                  items: viewModel.listmapel!,
                  selectedItem: selectedKelas,
                  itemToString: (item) => item.namaMapel ?? '-',
                  onChanged: (newValue) {
                    setState(() {
                      selectedKelas = newValue!;
                    });
                    viewModel.fetchListSiswa(selectedKelas!.mapelId.toString());
                  },
                ),
              ],
            ),
            SizedBox(height: 20),

            // Header
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(color: AppColors.primary),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("No", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    Text("Nama", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    Text("Detail", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
              ),
            ),

            // Daftar siswa dari viewModel
            Expanded(
              child: viewModel.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : viewModel.listsiwa == null
                  ? Center(child: Text("Pilih kelas terlebih dahulu"))
                  : ListView.builder(
                itemCount: viewModel.listsiwa!.length,
                itemBuilder: (context, index) {
                  final siswa = viewModel.listsiwa![index];
                  return ItemStatistikSiswa(
                    no: "${index + 1}",
                    nama: siswa.nama ?? "-",
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StatistikGuruDetail(krsId: siswa.krsId,)),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}