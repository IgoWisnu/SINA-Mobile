import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:sina_mobile/View/Component/OrangTua/CustomAppBarOrangTua.dart';
import 'package:sina_mobile/View/Component/OrangTua/CustomOrangTuaDrawer.dart';
import 'package:sina_mobile/View/Component/OrangTua/ItemRiwayatAbsensiOrtu.dart';
import 'package:sina_mobile/View/Component/RegularButton.dart';
import 'package:sina_mobile/View/Component/TitleBar.dart';
import 'package:sina_mobile/View/OrangTua/RiwayatAbsensiPage.dart';
import 'package:sina_mobile/ViewModel/OrangTua/RekapAbsensiOrtuViewModel.dart';

class RekapAbsensiOrtuPage extends StatefulWidget {
  @override
  State<RekapAbsensiOrtuPage> createState() => _RekapAbsensiOrtuPageState();
}

class _RekapAbsensiOrtuPageState extends State<RekapAbsensiOrtuPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String currentMenu = 'rekap_absensi';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<RekapAbsensiOrtuViewModel>(
        context,
        listen: false,
      ).getRekapAbsen();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<RekapAbsensiOrtuViewModel>(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomOrangTuaDrawer(selectedMenu: currentMenu),
      appBar: CustomAppBarOrangTua(
        onMenuPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      body:
          vm.isLoading
              ? Center(child: CircularProgressIndicator())
              : vm.error != null
              ? Center(child: Text('Error: ${vm.error}'))
              : vm.rekapabsendata == null
              ? Center(child: Text('Data tidak tersedia'))
              : SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      height: 250,
                      child: PieChart(
                        PieChartData(
                          sections: [
                            PieChartSectionData(
                              value: vm.rekapabsendata!.hadir.toDouble(),
                              title: '${vm.rekapabsendata!.hadir} Hadir',
                              color: Colors.blue,
                              radius: 50,
                              titleStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            PieChartSectionData(
                              value: vm.rekapabsendata!.izin.toDouble(),
                              title: '${vm.rekapabsendata!.izin} Izin',
                              color: Colors.green,
                              radius: 50,
                              titleStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            PieChartSectionData(
                              value: vm.rekapabsendata!.sakit.toDouble(),
                              title: '${vm.rekapabsendata!.sakit} Sakit',
                              color: Colors.orange,
                              radius: 50,
                              titleStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            PieChartSectionData(
                              value: vm.rekapabsendata!.alpha.toDouble(),
                              title: '${vm.rekapabsendata!.alpha} Alpha',
                              color: Colors.red,
                              radius: 50,
                              titleStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildLegend(
                          'Hadir',
                          Colors.blue,
                          vm.rekapabsendata!.hadir,
                        ),
                        buildLegend(
                          'Sakit',
                          Colors.orange,
                          vm.rekapabsendata!.sakit,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildLegend(
                          'Izin',
                          Colors.green,
                          vm.rekapabsendata!.izin,
                        ),
                        buildLegend(
                          'Alpha',
                          Colors.red,
                          vm.rekapabsendata!.alpha,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    TitleBar(judul: "Riwayat Absensi"),
                    ItemRiwayatAbsensiOrtu(),
                    SizedBox(height: 20),
                    RegularButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RiwayatAbsensiPage(),
                          ),
                        );
                      },
                      judul: "Lebih Banyak",
                    ),
                  ],
                ),
              ),
    );
  }

  Widget buildLegend(String label, Color color, int jumlah) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        SizedBox(width: 6),
        Text('$label: $jumlah'),
      ],
    );
  }
}
