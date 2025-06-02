import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/OrangTua/CustomOrangTuaDrawer.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class RekapAbsensiPage extends StatelessWidget {
  final Map<String, double> dataMap = {
    "Hadir": 320,
    "Izin": 20,
    "Sakit": 10,
    "Alpha": 17,
  };

  final Map<String, Color> colorMap = {
    "Hadir": Colors.blue,
    "Izin": Colors.teal,
    "Sakit": Colors.yellow,
    "Alpha": Colors.red,
  };

  final List<Map<String, String>> riwayat = [
    {"status": "Alpha", "tanggal": "35/04/2025", "keterangan": ""},
    {"status": "Sakit", "tanggal": "35/04/2025", "keterangan": "Surat Izin"},
    {"status": "Sakit", "tanggal": "35/04/2025", "keterangan": "Surat Izin"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomOrangTuaDrawer(selectedMenu: 'rekap_absensi'),
      key: _scaffoldKey,
      appBar: CustomAppBarNoDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown x/1
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "x/1",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Pie Chart
            Center(
              child: PieChart(
                dataMap: dataMap,
                animationDuration: const Duration(milliseconds: 800),
                chartLegendSpacing: 32,
                colorList: colorMap.values.toList(),
                chartRadius: MediaQuery.of(context).size.width / 2,
                legendOptions: const LegendOptions(showLegends: false),
                chartValuesOptions: const ChartValuesOptions(
                  showChartValues: false,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Keterangan warna
            Wrap(
              spacing: 20,
              runSpacing: 10,
              children:
                  dataMap.keys.map((key) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(width: 16, height: 16, color: colorMap[key]),
                        const SizedBox(width: 6),
                        Text("$key : ${dataMap[key]!.toInt()}"),
                      ],
                    );
                  }).toList(),
            ),

            const SizedBox(height: 16),

            // Keterangan bawah
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "*Absensi ini merupakan absensi selama 1 semester",
                style: TextStyle(fontSize: 12),
              ),
            ),

            const SizedBox(height: 24),

            // Riwayat Absensi
            Container(
              width: double.infinity,
              color: Colors.blue[700],
              padding: const EdgeInsets.all(12),
              child: const Text(
                "Riwayat Absensi",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),

            ...riwayat.map((absen) {
              return Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      absen["status"]!,
                      style: TextStyle(
                        color:
                            absen["status"] == "Alpha"
                                ? Colors.red
                                : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(absen["tanggal"]!),
                    trailing:
                        absen["keterangan"] != ""
                            ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  absen["keterangan"]!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(Icons.arrow_forward_ios, size: 16),
                              ],
                            )
                            : null,
                  ),
                  const Divider(height: 1),
                ],
              );
            }).toList(),

            const SizedBox(height: 16),

            // Tombol "Lebih Banyak"
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/riwayat-absensi');
                },
                child: const Text(
                  "Lebih banyak",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
