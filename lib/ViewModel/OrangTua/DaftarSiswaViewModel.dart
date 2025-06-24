import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/OrangTua/Siswa.dart';

import 'package:sina_mobile/service/repository/OrangTua/DaftarSiswaRepository.dart';

class DaftarSiswaViewModel extends ChangeNotifier {
  final DaftarSiswaRepository repository;

  DaftarSiswaViewModel({required this.repository});

  List<Siswa> _siswaList = [];
  List<Siswa> get siswaList => _siswaList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchSiswa() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _siswaList = await repository.fetchSiswaByOrtu();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
