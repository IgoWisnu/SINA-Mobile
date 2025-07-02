import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/View/Component/OrangTua/CustomAppBarOrangTua.dart';
import 'package:sina_mobile/View/Component/OrangTua/CustomOrangTuaDrawer.dart';
import 'package:sina_mobile/View/OrangTua/DetailRaportPage.dart';
import 'package:sina_mobile/ViewModel/OrangTua/RaporOrtuViewModel.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class ListRapotPage extends StatefulWidget {
  const ListRapotPage({super.key});

  @override
  State<ListRapotPage> createState() => _ListRapotPageState();
}

class _ListRapotPageState extends State<ListRapotPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final prefs = await SharedPreferences.getInstance();
      final nis = prefs.getString('nis');
      if (nis != null) {
        Provider.of<RaporOrtuViewModel>(context, listen: false).fetchRapor();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String currentMenu = 'list_rapot';

    return Scaffold(
      drawer: CustomOrangTuaDrawer(selectedMenu: currentMenu),
      key: _scaffoldKey,
      appBar: CustomAppBarOrangTua(
        onMenuPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Consumer<RaporOrtuViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (viewModel.errorMessage != null) {
                return Center(child: Text(viewModel.errorMessage!));
              }

              final rapor = viewModel.studentRapor;

              if (rapor == null || rapor.riwayatRapor.isEmpty) {
                return const Center(child: Text('Data rapor tidak ditemukan.'));
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // Nama siswa

                  // Label Biru
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2972FE),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      "Kelas/Semester",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  // List Rapot
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      child: ListView.separated(
                        itemCount: rapor.riwayatRapor.length,
                        separatorBuilder:
                            (context, index) => const Divider(thickness: 1),
                        itemBuilder: (context, index) {
                          final item = rapor.riwayatRapor[index];
                          return Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  item.namaKelas,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  rapor.nama,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_circle_right_outlined,
                                  size: 20,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) => DetailRapotPage(
                                            krsId: item.krsId,
                                          ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
