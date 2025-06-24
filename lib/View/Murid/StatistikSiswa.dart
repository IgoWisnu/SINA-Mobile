import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sina_mobile/Model/StatistikSiswa.dart';
import 'package:sina_mobile/View/Component/CustomAppBar.dart';
import 'package:sina_mobile/View/Component/Murid/CustomMuridDrawer.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sina_mobile/View/Component/TitleBarLine.dart';
import 'package:sina_mobile/ViewModel/StatistikViewModel.dart';

class StatistikSiswa extends StatefulWidget{
  const StatistikSiswa({super.key});

  @override
  State<StatistikSiswa> createState() => _StatistikSiswaState();
}

class _StatistikSiswaState extends State<StatistikSiswa> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String currentMenu = 'statistik';

  String? selectedTahunAkademikId;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final vm = Provider.of<StatistikViewModel>(context, listen: false);
      vm.getlistStatistik();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<StatistikViewModel>(context);
    final detailKelas = vm.detailkelas;
    final statistikData = vm.statistikdata;

    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomMuridDrawer(selectedMenu: currentMenu),
      appBar: CustomAppBar(
        onMenuPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      body: vm.isLoading
          ? Center(child: CircularProgressIndicator())
          : detailKelas == null
          ? Center(child: Text("Tidak ada data kelas"))
          : SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                    border:  Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),

                  ),
                  child: DropdownButton<String>(
                    value: selectedTahunAkademikId,
                    hint: Text("Pilih Tahun"),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedTahunAkademikId = value;
                        });
                        vm.getStatistik(value);
                      }
                    },
                    items: [
                      DropdownMenuItem(
                        value: detailKelas.tahunAkademik.id,
                        child: Text('${detailKelas.tingkat} - ${detailKelas.tahunAkademik.periode}'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            statistikData == null
                ? Text("Belum ada data statistik")
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                TitleBarLine(judul: 'Nilai Pengetahuan'),
                SizedBox(height: 200, child: buildBarChart(statistikData, 'pengetahuan')),
                SizedBox(height: 20),
                TitleBarLine(judul: 'Nilai Keterampilan'),
                SizedBox(height: 200, child: buildBarChart(statistikData, 'keterampilan')),
                SizedBox(height: 30),
                TitleBarLine(judul: 'Nilai Akhir'),
                SizedBox(height: 200, child: buildBarChart(statistikData, 'akhir')),
                SizedBox(height: 20,)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBarChart(StatistikData data, String tipe) {
    return BarChart(
      BarChartData(
        barGroups: List.generate(data.detailNilai.length, (i) {
          final item = data.detailNilai[i];
          double value;

          switch (tipe) {
            case 'pengetahuan':
              value = (item.nilaiPengetahuan ?? 0).toDouble();
              break;
            case 'keterampilan':
              value = (item.nilaiKeterampilan ?? 0).toDouble();
              break;
            case 'akhir':
              value = (item.nilaiAkhir ?? 0).toDouble();
              break;
            default:
              value = 0;
          }

          return BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: value,
                width: 14,
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          );
        }),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) =>
                  Text(value.toInt().toString()),
              reservedSize: 28,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, meta) {
                int index = value.toInt();
                if (index < data.detailNilai.length) {
                  return Transform.rotate(
                    angle: -0.5,
                    child: Text(
                      data.detailNilai[index].namaMapel,
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
