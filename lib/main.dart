import 'package:flutter/material.dart';
import 'package:sina_mobile/View/OrangTua/DetailPengumumanPage.dart';
import 'package:sina_mobile/View/OrangTua/DashboardOrangTua.dart';
import 'package:sina_mobile/View/OrangTua/DetailRaportPage.dart';
import 'package:sina_mobile/View/OrangTua/FormPengajuanPage.dart';
import 'package:sina_mobile/View/OrangTua/JadwalPelajaranPage.dart';
import 'package:sina_mobile/View/OrangTua/ListRaportPage.dart';
import 'package:sina_mobile/View/OrangTua/PengumumanOrangTuaPage.dart';
import 'package:sina_mobile/View/OrangTua/ProfilOrangTuaPage.dart';
import 'package:sina_mobile/View/OrangTua/RekapAbsensiPage.dart';
import 'package:sina_mobile/View/OrangTua/RingkasanPengajuanPage.dart';
import 'package:sina_mobile/View/OrangTua/RiwayatAbsensiPage.dart';
import 'package:sina_mobile/View/OrangTua/StatistikPage.dart';
import 'package:sina_mobile/View/loginPage.dart';
import 'package:sina_mobile/View/regisPage.dart';
import 'package:sina_mobile/View/registerPage.dart';
// import 'package:sina_mobile/View/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SINA_Mobile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light, // Ini penting!
        ),
        useMaterial3: true, // opsional, pakai Material 3
        fontFamily: 'Poppins',
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 16.0),
          bodyMedium: TextStyle(fontSize: 14.0),
          bodySmall: TextStyle(fontSize: 14.0),
          titleLarge: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark, // Ini juga penting!
        ),
        useMaterial3: true,
        fontFamily: 'Poppins',
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 16.0),
          bodyMedium: TextStyle(fontSize: 14.0),
          bodySmall: TextStyle(fontSize: 14.0),
          titleLarge: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      home: Dashboardorangtua(),
      routes: {
        '/loginPage': (context) => LoginPage(),
        '/regisPage': (context) => RegisPage(),
        '/registerPage': (context) => RegisterPage(),
        '/detail-pengumuman': (context) => DetailPengumumanPage(),
        '/statistik': (context) => StatistikPage(),
        '/jadwal': (context) => JadwalPelajaranPage(),
        '/list-rapot': (context) => ListRapotPage(),
        '/detail-rapot': (context) => DetailRaportPage(),
        '/rekap': (context) => RekapAbsensiPage(),
        '/riwayat-absensi': (context) => RiwayatAbsensiPage(),
        '/pengumuman': (context) => PengumumanOrangTuaPage(),
        '/pengajuan': (context) => FormPengajuanPage(),
        '/ringkasan-pengajuan':
            (context) => RingkasanPengajuanPage(
              namaSiswa: '',
              tanggalIzin: '',
              jenisIzin: '',
              keterangan: '',
            ),
        '/profil': (context) => ProfilOrangTuaPage(),
        // '/dashboard': (context) => dashboard(),
      },
    );
  }
}
