import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/OrangTua/CustomOrangTuaDrawer.dart';
import 'package:sina_mobile/View/OrangTua/DetailPengumumanPage.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class StatistikPage extends StatefulWidget {
  @override
  State<StatistikPage> createState() => _StatistikPageState();
}

class _StatistikPageState extends State<StatistikPage> {
  String selectedKelas = 'XI/1';
  final List<String> kelasList = ['XI/1', 'XI/2', 'XI/3'];

  final List<String> subjects = [
    'Bahasa Indonesia',
    'Matematika',
    'Kewarganegaraan',
    'Bahasa Bali',
    'Agama',
    'HTML',
    'CSS',
    'Javascript',
  ];

  final Map<String, List<double>> nilaiData = {
    'X/1': [60, 70, 50, 65, 60, 80, 75, 66],
    'X/2': [65, 75, 55, 67, 70, 85, 78, 70],
    'X/1+': [60, 70, 85, 81, 81, 90, 90, 75],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomOrangTuaDrawer(selectedMenu: currentMenu),
      key: _scaffoldKey,
      appBar: CustomAppBarNoDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Title(color: Colors.black, child: Text('TAHUN AKADEMIK 2024/2025')),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Kelas ', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 10),
                DropdownButton<String>(
                  value: selectedKelas,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedKelas = value;
                      });
                    }
                  },
                  items:
                      kelasList
                          .map(
                            (kelas) => DropdownMenuItem(
                              value: kelas,
                              child: Text(kelas),
                            ),
                          )
                          .toList(),
                ),
              ],
            ),
            SizedBox(
              height: 300,
              child: BarChart(
                BarChartData(
                  barGroups: List.generate(subjects.length, (i) {
                    final value = nilaiData['X/1+']![i];
                    return BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: value,
                          width: 16,
                          color: Colors.purpleAccent,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    );
                  }),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget:
                            (value, meta) => Text(value.toInt().toString()),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();
                          if (index < subjects.length) {
                            return Transform.rotate(
                              angle: -0.5,
                              child: Text(
                                subjects[index],
                                style: TextStyle(fontSize: 10),
                              ),
                            );
                          }
                          return Text('');
                        },
                        interval: 1,
                      ),
                    ),
                  ),
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  LineChartBarData lineChart(String groupKey, Color color) {
    final data = nilaiData[groupKey]!;
    return LineChartBarData(
      spots: List.generate(data.length, (i) => FlSpot(i.toDouble(), data[i])),
      isCurved: true,
      color: color,
      barWidth: 3,
      dotData: FlDotData(show: true),
    );
  }
}
