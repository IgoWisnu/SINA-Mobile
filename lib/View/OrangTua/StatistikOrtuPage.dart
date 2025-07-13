// ✅ FINAL UI StatistikOrtuPage dengan MVVM, Bar Chart, dan Tampilan Cantik
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sina_mobile/Model/OrangTua/StatistikOrtu.dart';
import 'package:sina_mobile/View/Component/OrangTua/CustomAppBarOrangTua.dart';
import 'package:sina_mobile/View/Component/OrangTua/CustomOrangTuaDrawer.dart';
import 'package:sina_mobile/View/Component/TitleBarLine.dart';
import 'package:sina_mobile/ViewModel/OrangTua/StatistikNilaiViewModel.dart';

class StatistikOrtuPage extends StatefulWidget {
  const StatistikOrtuPage({super.key});

  @override
  State<StatistikOrtuPage> createState() => _StatistikOrtuPageState();
}

class _StatistikOrtuPageState extends State<StatistikOrtuPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String currentMenu = 'statistik';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final vm = Provider.of<StatistikNilaiViewModel>(context, listen: false);
      vm.getStatistik();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<StatistikNilaiViewModel>(context);
    final statistik = vm.statistik;

    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomOrangTuaDrawer(selectedMenu: currentMenu),
      appBar: CustomAppBarOrangTua(
        onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
      ),
      body:
          vm.isLoading
              ? const Center(child: CircularProgressIndicator())
              : statistik == null
              ? const Center(child: Text("Belum ada data statistik"))
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      color: Colors.blue.shade50,
                      child: ListTile(
                        leading: const Icon(Icons.person, color: Colors.blue),
                        title: Text(
                          "Siswa: ${statistik.siswa}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "Kelas: ${statistik.kelasTersedia.join(", ")}",
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TitleBarLine(judul: 'Statistik Nilai'),
                    const SizedBox(height: 10),
                    statistik.data.isEmpty
                        ? const Text("Tidak ada data nilai.")
                        : Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          height: 300,
                          child: buildBarChart(statistik.data),
                        ),
                  ],
                ),
              ),
    );
  }

  Widget buildBarChart(List<StatistikMapel> data) {
    return BarChart(
      BarChartData(
        barGroups: List.generate(data.length, (i) {
          final item = data[i];
          final double nilaiDouble = item.nilai ?? 0;
          return BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: nilaiDouble,
                width: 14,
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          );
        }),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 30),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, _) {
                int index = value.toInt();
                if (index < data.length) {
                  return Transform.rotate(
                    angle: -0.5,
                    child: Text(
                      data[index].mapel,
                      style: const TextStyle(fontSize: 10),
                    ),
                  );
                }
                return const Text('');
              },
            ),
          ),
        ),
        gridData: FlGridData(show: true),
        borderData: FlBorderData(show: false),
      ),
    );
  }
}
