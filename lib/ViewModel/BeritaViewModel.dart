import 'package:flutter/material.dart';
import 'package:sina_mobile/service/repository/AuthRepository.dart';
import 'package:sina_mobile/service/repository/BeritaRepository.dart';
import 'package:sina_mobile/service/repository/KelasRepository.dart';

import '../Model/kelas.dart';
import 'package:sina_mobile/Model/Berita.dart';


class BeritaViewModel extends ChangeNotifier {
  final BeritaRepository repository;

  BeritaViewModel({required this.repository});

  List<Berita> _beritaList = [];
  List<Berita> get beritaList => _beritaList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchBerita() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _beritaList = await repository.getBerita();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }


}