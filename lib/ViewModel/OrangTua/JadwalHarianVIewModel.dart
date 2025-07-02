import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/OrangTua/jadwalRespon.dart';
import 'package:sina_mobile/service/repository/OrangTua/JadwalHarianRepository.dart';

class JadwalHarianViewModel extends ChangeNotifier {
  final JadwalHarianRepository repository;

  JadwalHarianViewModel({required this.repository});

  List<Jadwal> _jadwalList = [];
  List<Jadwal> get jadwalList => _jadwalList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchJadwal(String hari) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _jadwalList = await repository.getJadwal(hari);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
