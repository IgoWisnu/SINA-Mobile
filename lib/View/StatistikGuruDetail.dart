import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sina_mobile/Model/Guru/StatistikSiswaResponse.dart';
import 'package:sina_mobile/View/Component/CustomAppBar.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/Murid/CustomMuridDrawer.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sina_mobile/ViewModel/Guru/StatistikGuruViewModel.dart';

class StatistikGuruDetail extends StatefulWidget{
  final String krsId;

  const StatistikGuruDetail({super.key, required this.krsId});

  @override
  State<StatistikGuruDetail> createState() => _StatistikGuruDetailState();
}

class _StatistikGuruDetailState extends State<StatistikGuruDetail> {
  @override
  void initState() {
    super.initState();

    // Panggil fetchStatistik saat widget pertama kali dibuka
    Future.microtask(() {
      final viewModel = Provider.of<StatistikGuruViewModel>(context, listen: false);
      viewModel.fetchStatistik("some_krs_id"); // Ganti dengan krsId sesuai konteks
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<StatistikGuruViewModel>(context);
    final List<StatistikGuru> data = viewModel.statistiksiswa ?? [];

    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'TAHUN AKADEMIK 2024/2025',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Grafik
            SizedBox(
              height: 300,
              child: viewModel.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : data.isEmpty
                  ? const Center(child: Text("Tidak ada data"))
                  : BarChart(
                BarChartData(
                  barGroups: List.generate(data.length, (i) {
                    final nilai = data[i].nilai.toDouble();
                    return BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: nilai,
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
                        getTitlesWidget: (value, meta) =>
                            Text(value.toInt().toString()),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();
                          if (index < data.length) {
                            return Transform.rotate(
                              angle: -0.5,
                              child: Text(
                                data[index].namaMapel,
                                style: const TextStyle(fontSize: 10),
                              ),
                            );
                          }
                          return const Text('');
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
}