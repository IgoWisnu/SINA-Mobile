import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/OrangTua/SuratIjin.dart';
import 'package:sina_mobile/service/repository/OrangTua/SuratIjinRepository.dart';

class SuratIzinViewModel extends ChangeNotifier {
  final SuratIzinRepository repository;

  SuratIzinViewModel({required this.repository});

  List<SuratIzin> _riwayat = [];
  List<SuratIzin> get riwayat => _riwayat;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchRiwayat() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _riwayat = await repository.getSuratIjin();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> refreshRiwayat() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _riwayat = await repository.getSuratIjin();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
