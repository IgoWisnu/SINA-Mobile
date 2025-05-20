import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sina_mobile/View/loginPage.dart';
import 'package:sina_mobile/View/regisPage.dart';
import 'package:sina_mobile/View/registerPage.dart';
import 'package:sina_mobile/View/dashboard.dart';
import 'package:sina_mobile/service/api/ApiService.dart';
import 'package:sina_mobile/service/repository/AuthRepository.dart';

import 'ViewModel/AuthViewModel.dart';

void main() {
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
            repository: AuthRepository(ApiService()),
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
        home: const LoginPage(), // default ke LoginPage
        // routes: {
        //   '/loginPage': (context) => const LoginPage(),
        //   '/regisPage': (context) => const RegisPage(),
        //   '/registerPage': (context) => const RegisterPage(),
        //   '/dashboard': (context) => const Dashboard(),
        // },
      ),
    );
  }
}
