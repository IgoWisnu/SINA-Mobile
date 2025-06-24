import 'package:flutter/material.dart';
import 'package:sina_mobile/service/repository/AuthRepository.dart';
import 'package:sina_mobile/Model/OrangTua/OrangTuaResponse.dart';
import 'package:sina_mobile/service/repository/OrangTua/BiodataOrtuRepository.dart';

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
      print('Data ortu berhasil diambil: $_ortu');
    } catch (e) {
      _error = e.toString();
      print('Terjadi error saat fetchBiodataOrtu: $_error');
    }

    _isLoading = false;
    notifyListeners();
  }
}
