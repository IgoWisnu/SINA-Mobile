import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/Guru/Guru.dart';
import 'package:sina_mobile/Model/SiswaResponse.dart';
import 'package:sina_mobile/service/repository/AuthRepository.dart';
import 'package:sina_mobile/service/repository/BiodataRepository.dart';
import 'package:sina_mobile/service/repository/Guru/BiodataGuruRepository.dart';
import 'package:sina_mobile/service/repository/KelasRepository.dart';


class ProfilGuruViewModel extends ChangeNotifier {
  final BiodataGuruRepository repository;

  ProfilGuruViewModel({required this.repository});

  Guru? _guru;
  Guru? get guru => _guru; // ← perbaikan di sini

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchBiodataGuru() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _guru = await repository.fetchBiodataGuru();
      print("✅ Data guru berhasil diambil: $_guru");
      print("✅ Data guru berhasil diambil: ${_guru!.toJson()}");
    } catch (e) {
      _error = e.toString();
      print("❌ Error saat ambil data guru: $_error");
    }

    _isLoading = false;
    notifyListeners();
  }
}