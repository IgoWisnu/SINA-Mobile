import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/OrangTua/CustomAppBarOrangTua.dart';
import 'package:sina_mobile/View/Component/OrangTua/CustomOrangTuaDrawer.dart';
import 'package:sina_mobile/View/OrangTua/DetailPengumumanPage.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class JadwalPelajaranPage extends StatelessWidget {
  final Map<String, List<Map<String, String>>> jadwalHarian = {
    'Senin': [
      {"waktu": "08.00\n09.40", "mapel": "Matematika", "guru": "Budi"},
      {"waktu": "09.50\n11.30", "mapel": "Bahasa Indonesia", "guru": "Ani"},
      {"waktu": "11.40\n13.20", "mapel": "Istirahat", "guru": ""},
      {"waktu": "13.30\n15.10", "mapel": "IPA", "guru": "Cici"},
    ],
    'Selasa': [
      {"waktu": "08.00\n09.40", "mapel": "Bahasa Inggris", "guru": "Dedi"},
      {"waktu": "09.50\n11.30", "mapel": "Seni Budaya", "guru": "Eka"},
      {"waktu": "11.40\n13.20", "mapel": "Istirahat", "guru": ""},
      {"waktu": "13.30\n15.10", "mapel": "Pendidikan Jasmani", "guru": "Fani"},
    ],
    'Rabu': [
      {"waktu": "08.00\n09.40", "mapel": "Sejarah", "guru": "Gani"},
      {"waktu": "09.50\n11.30", "mapel": "Geografi", "guru": "Hani"},
      {"waktu": "11.40\n13.20", "mapel": "Istirahat", "guru": ""},
      {"waktu": "13.30\n15.10", "mapel": "Ekonomi", "guru": "Ika"},
    ],
    'Kamis': [
      {"waktu": "08.00\n09.40", "mapel": "Kimia", "guru": "Joni"},
      {"waktu": "09.50\n11.30", "mapel": "Fisika", "guru": "Kiki"},
      {"waktu": "11.40\n13.20", "mapel": "Istirahat", "guru": ""},
      {"waktu": "13.30\n15.10", "mapel": "Biologi", "guru": "Lina"},
    ],
    'Jumat': [
      {"waktu": "08.00\n09.40", "mapel": "Agama", "guru": "Maman"},
      {"waktu": "09.50\n11.30", "mapel": "Kewarganegaraan", "guru": "Nina"},
      {"waktu": "11.40\n13.20", "mapel": "Istirahat", "guru": ""},
      {"waktu": "13.30\n15.10", "mapel": "Teknologi Informasi", "guru": "Oki"},
    ],
  };

  String selectedDay = 'Senin';
  String currentMenu = 'jadwal_pelajaran';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomOrangTuaDrawer(selectedMenu: currentMenu),
      key: _scaffoldKey,
      appBar: CustomAppBarOrangTua(
        onMenuPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          // Dropdown Hari
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: InputBorder.none,
              ),
              value: selectedDay,
              items:
                  ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat']
                      .map(
                        (hari) =>
                            DropdownMenuItem(value: hari, child: Text(hari)),
                      )
                      .toList(),
              onChanged: (value) {
                selectedDay = value!;
                (context as Element).markNeedsBuild();
              },
            ),
          ),
          const SizedBox(height: 10),
          // Header Table
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              color: Colors.blue[700],
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: const [
                  Expanded(
                    flex: 2,
                    child: Text('Waktu', style: TextStyle(color: Colors.white)),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Mata Pelajaran',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Guru Mengajar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Daftar Jadwal
          Expanded(
            child: ListView.separated(
              itemCount: jadwalHarian[selectedDay]!.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = jadwalHarian[selectedDay]![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Expanded(flex: 2, child: Text(item['waktu'] ?? '')),
                      Expanded(flex: 3, child: Text(item['mapel'] ?? '')),
                      Expanded(flex: 3, child: Text(item['guru'] ?? '')),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
