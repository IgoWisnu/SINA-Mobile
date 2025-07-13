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
    const String currentMenu = 'list_rapot';

    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomOrangTuaDrawer(selectedMenu: currentMenu),
      appBar: CustomAppBarOrangTua(
        onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
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

                  // Label Header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2972FE),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Text(
                      "Daftar Rapor Siswa",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // List Rapor
                  Expanded(
                    child: ListView.separated(
                      itemCount: rapor.riwayatRapor.length,
                      separatorBuilder:
                          (context, index) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = rapor.riwayatRapor[index];

                        return Material(
                          elevation: 2,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.namaKelas,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        rapor.nama,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                IconButton(
                                  icon: const Icon(
                                    Icons.arrow_circle_right_outlined,
                                    color: Colors.blue,
                                    size: 26,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (_) =>
                                                DetailRapotPage(nis: rapor.nis),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
