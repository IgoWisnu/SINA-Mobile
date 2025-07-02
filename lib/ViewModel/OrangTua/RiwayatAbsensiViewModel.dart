// lib/ViewModel/OrangTua/RiwayatAbsensiViewModel.dart
import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/OrangTua/RiwayatAbsensi.dart';
import 'package:sina_mobile/service/repository/OrangTua/RiwayatAbsensiRepository.dart';

class RiwayatAbsensiViewModel with ChangeNotifier {
  final RiwayatAbsensiRepository repository;

  RiwayatAbsensiViewModel({required this.repository});

  List<RiwayatAbsensi> _riwayat = [];
  bool _isLoading = false;
  String? _error;

  List<RiwayatAbsensi> get riwayat => _riwayat;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchRiwayatAbsensi() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _riwayat = await repository.getRiwayatAbsensi();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
