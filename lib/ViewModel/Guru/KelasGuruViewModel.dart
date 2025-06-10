import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/Guru/KelasGuru.dart';
import 'package:sina_mobile/service/repository/AuthRepository.dart';
import 'package:sina_mobile/service/repository/Guru/KelasGuruRepository.dart';
import 'package:sina_mobile/service/repository/KelasRepository.dart';


class KelasGuruViewModel extends ChangeNotifier {
  final KelasGuruRepository repository;

  KelasGuruViewModel({required this.repository});

  List<KelasItem> _kelasList = [];
  List<KelasItem> get kelasList => _kelasList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchKelas() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _kelasList = await repository.getKelas();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }


}