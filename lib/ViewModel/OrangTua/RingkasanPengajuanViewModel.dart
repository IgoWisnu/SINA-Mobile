import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/OrangTua/SuratIjinDetail.dart';
import 'package:sina_mobile/service/repository/OrangTua/SuratIjinDetailRepository.dart';

class RingkasanPengajuanViewModel extends ChangeNotifier {
  final SuratIjinDetailRepository repository;

  RingkasanPengajuanViewModel({required this.repository});

  DetailSuratIzin? _detail;
  DetailSuratIzin? get detail => _detail;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchDetail(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _detail = await repository.fetchDetailSurat(id);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
