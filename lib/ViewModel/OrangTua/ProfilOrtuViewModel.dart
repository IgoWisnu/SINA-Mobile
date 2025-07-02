import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/OrangTua/OrangTuaResponse.dart';
import 'package:sina_mobile/Model/OrangTua/UpdatePasswordRequest.dart';
import 'package:sina_mobile/service/repository/OrangTua/BiodataOrtuRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfilOrtuViewModel extends ChangeNotifier {
  final BiodataOrtuRepository repository;

  ProfilOrtuViewModel({required this.repository});

  Ortu? _ortu;
  Ortu? get ortu => _ortu;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchBiodataOrtu() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _ortu = await repository.fetchBiodataOrtu();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> uploadFoto(File imageFile) async {
    try {
      _isLoading = true;
      notifyListeners();

      await repository.uploadFotoProfil(imageFile);
      await fetchBiodataOrtu();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfilOrtu({
    required String tempatLahir,
    required String tanggalLahir,
    required String alamat,
    required String noTelepon,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      if (token == null) throw Exception("Token tidak ditemukan");

      final response = await http.patch(
        Uri.parse('http://sina.pnb.ac.id:3006/api/dashboard/biodata'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'tempat_lahir_ortu': tempatLahir,
          'tanggal_lahir_ortu': tanggalLahir,
          'alamat': alamat,
          'no_telepon': noTelepon,
        }),
      );

      if (response.statusCode == 200) {
        await fetchBiodataOrtu();
      } else {
        throw Exception("Gagal memperbarui profil: ${response.body}");
      }
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
