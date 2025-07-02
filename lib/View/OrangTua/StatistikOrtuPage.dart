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
              ? Center(child: CircularProgressIndicator())
              : statistik == null
              ? Center(child: Text("Belum ada data statistik"))
              : SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Siswa: ${statistik.siswa}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Kelas tersedia: ${statistik.kelasTersedia.join(", ")}",
                    ),
                    SizedBox(height: 20),
                    TitleBarLine(judul: 'Statistik Nilai'),
                    SizedBox(height: 200, child: buildBarChart(statistik.data)),
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
          return BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: item.nilai.toDouble(),
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
                      style: TextStyle(fontSize: 10),
                    ),
                  );
                }
                return Text('');
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
