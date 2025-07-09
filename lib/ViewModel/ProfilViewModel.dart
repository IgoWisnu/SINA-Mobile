import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/SiswaResponse.dart';
import 'package:sina_mobile/service/repository/AuthRepository.dart';
import 'package:sina_mobile/service/repository/BiodataRepository.dart';
import 'package:sina_mobile/service/repository/KelasRepository.dart';

import '../Model/user.dart';
import '../Model/kelas.dart';



class ProfilViewModel extends ChangeNotifier {
  final BiodataRepository repository;

  ProfilViewModel({required this.repository});

  Siswa? _siswa;
  Siswa? get siswa => _siswa;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchBiodataSiswa() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _siswa = await repository.fetchBiodataSiswa();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateProfilSiswa(Siswa updatedSiswa, {File? imageFile}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await repository.UpdateBiodataSiswa(updatedSiswa, imageFile: imageFile);
      await fetchBiodataSiswa(); // Refresh data
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updatePassword(
      String pwLama,
      String pwBaru
      ) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await repository.updatePassword(pwLama, pwBaru);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

}