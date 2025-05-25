import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';

class PengumumanOrangTuaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                PengumumanCard(
                  imagePath: 'lib/asset/image/Nyepih.png',
                  title: 'Menjelang Hari Raya Nyepi, Siswa Libur 2 Minggu',
                  description:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
                  date: '14 Jan 2024',
                ),
                SizedBox(height: 16),
                PengumumanCard(
                  imagePath:
                      'lib/asset/image/Nyepih.png', // Example for additional card
                  title: 'Contoh Pengumuman Lain',
                  description: 'Ini adalah contoh pengumuman lainnya...',
                  date: '15 Jan 2024',
                ),
                // Add more PengumumanCard widgets as needed
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PengumumanCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final String date;

  const PengumumanCard({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.date,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.pushNamed(context, '/detail-pengumuman');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                imagePath,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  SizedBox(height: 6),
                  Text(
                    description,
                    style: TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                  SizedBox(height: 12),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      date,
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
