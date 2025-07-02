import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/OrangTua/raport.dart';
import 'package:sina_mobile/service/repository/OrangTua/RaporRepository.dart';

class RaporOrtuViewModel extends ChangeNotifier {
  final RaporRepository repository;

  RaporOrtuViewModel({required this.repository});

  RaporSiswa? _studentRapor;
  RaporSiswa? get studentRapor => _studentRapor;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchRapor() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _studentRapor = await repository.getRaport();
      if (_studentRapor == null || _studentRapor!.riwayatRapor.isEmpty) {
        _errorMessage = "Data rapor kosong.";
      }
    } catch (e) {
      _errorMessage = "Gagal mengambil data: ${e.toString()}";
    }

    _isLoading = false;
    notifyListeners();
  }
}
