import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/Model/OrangTua/RegisterInitResponse.dart';
import 'package:sina_mobile/service/api/ApiServiceAuth.dart';

class RegisterRepository {
  final ApiServiceAuth apiService;
  RegisterRepository({required this.apiService});

  Future<RegisterInitResponse> startRegistration(
    String nis,
    String statusOrtu,
  ) async {
    final response = await http.post(
      Uri.parse('http://sina.pnb.ac.id:3005/api/register/ortu'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'nis': nis, 'status_ortu': statusOrtu.toLowerCase()}),
    );

    if (response.statusCode == 200) {
      return RegisterInitResponse.fromJson(jsonDecode(response.body));
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Failed to start registration');
    }
  }

  Future<String> validateOtpOnly({
    required String nis,
    required String statusOrtu,
    required String otp,
    required String email,
  }) async {
    final response = await http.post(
      Uri.parse('http://sina.pnb.ac.id:3005/api/register/ortu/verify-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nis': nis,
        'status_ortu': statusOrtu.toLowerCase(),
        'otp': otp,
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData['registration_token'];
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'OTP tidak valid atau kadaluarsa');
    }
  }

  Future<RegisterVerifyResponse> completeRegistration({
    required String password,
    required String confirmPassword,
    required String imei,
    required String registrationToken,
  }) async {
    final response = await http.post(
      Uri.parse('http://sina.pnb.ac.id:3005/api/register/ortu/complete'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'password': password,
        'confirm_password': confirmPassword,
        'imei': imei,
        'registration_token': registrationToken,
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        'user_id',
        jsonResponse['data']['user_id'].toString(),
      );
      await prefs.setString('email', jsonResponse['data']['email']);
      await prefs.setString('status_ortu', jsonResponse['data']['status_ortu']);
      await prefs.setString('imei', jsonResponse['data']['imei']);

      return RegisterVerifyResponse.fromJson(jsonResponse);
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Gagal menyelesaikan registrasi');
    }
  }
}
