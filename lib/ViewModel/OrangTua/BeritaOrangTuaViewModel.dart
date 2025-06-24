import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/OrangTua/BeritaOrangTua.dart';
import 'package:sina_mobile/service/repository/OrangTua/BeritaOrangTuaRepository.dart';

class BeritaOrangTuaViewModel extends ChangeNotifier {
  final BeritaOrangTuaRepository repository;

  BeritaOrangTuaViewModel({required this.repository});

  List<Berita> _beritaListOrangTua = [];
  List<Berita> get beritaListOrangTua => _beritaListOrangTua;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchBeritaOrangTua() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _beritaListOrangTua = await repository.getBeritaOrangTua();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
