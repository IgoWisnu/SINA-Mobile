import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sina_mobile/View/loginPage.dart';
import 'package:sina_mobile/View/regisPage.dart';
import 'package:sina_mobile/View/registerPage.dart';
import 'package:sina_mobile/View/dashboard.dart';
import 'package:sina_mobile/ViewModel/BeritaViewModel.dart';
import 'package:sina_mobile/ViewModel/DashboardViewModel.dart';
import 'package:sina_mobile/ViewModel/JadwalViewModel.dart';
import 'package:sina_mobile/ViewModel/KelasDetailViewModel.dart';
import 'package:sina_mobile/ViewModel/KelasViewModel.dart';
import 'package:sina_mobile/ViewModel/ProfilViewModel.dart';
import 'package:sina_mobile/ViewModel/RekapAbsensiViewModel.dart';
import 'package:sina_mobile/service/api/ApiService.dart';
import 'package:sina_mobile/service/api/ApiServiceAuth.dart';
import 'package:sina_mobile/service/repository/AbsensiRepository.dart';
import 'package:sina_mobile/service/repository/AuthRepository.dart';
import 'package:sina_mobile/service/repository/BeritaRepository.dart';
import 'package:sina_mobile/service/repository/BiodataRepository.dart';
import 'package:sina_mobile/service/repository/DashboardRepository.dart';
import 'package:sina_mobile/service/repository/JadwalRepository.dart';
import 'package:sina_mobile/service/repository/KelasRepository.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'ViewModel/AuthViewModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null); // Inisialisasi locale Indonesia
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthViewModel(
            repository: AuthRepository(ApiServiceAuth()),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => KelasViewModel(
            repository: KelasRepository(ApiService()),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => KelasDetailViewModel(
            repository: KelasRepository(ApiService()),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => JadwalViewModel(
            repository: JadwalRepository(ApiService())
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => RekapAbsensiViewModel(
              repository: AbsensiRepository(ApiService())
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => BeritaViewModel(
              repository: BeritaRepository(ApiService())
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfilViewModel(
              repository: BiodataRepository(ApiService())
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DashboardViewModel(
              repository: DashboardRepository(ApiService())
          ),
        ),
      ],
      child: MaterialApp(
        title: 'SINA_Mobile',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          fontFamily: 'Poppins',
          textTheme: const TextTheme(
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
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
          fontFamily: 'Poppins',
          textTheme: const TextTheme(
            bodyLarge: TextStyle(fontSize: 16.0),
            bodyMedium: TextStyle(fontSize: 14.0),
            bodySmall: TextStyle(fontSize: 14.0),
            titleLarge: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        home: const LoginPage(),
        routes: {
          '/loginPage': (context) => LoginPage(),
          '/regisPage': (context) => RegisPage(),
          '/registerPage': (context) => RegisterPage(),
        },// default ke LoginPage
      ),
    );
  }
}
