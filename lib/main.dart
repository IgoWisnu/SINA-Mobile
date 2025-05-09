import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Lib/loginPage.dart';
import 'package:sina_mobile/View/Lib/regisPage.dart';
import 'package:sina_mobile/View/Lib/registerPage.dart';
import 'package:sina_mobile/View/dashboard.dart';

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
      home: LoginPage(),
      routes: {
        '/loginPage': (context) => LoginPage(),
        '/regisPage': (context) => RegisPage(),
        '/registerPage': (context) => RegisterPage(),
        '/dashboard': (context) => dashboard(),
      },
    );
  }
}
