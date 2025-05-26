import 'package:flutter/material.dart';
import 'package:sina_mobile/service/repository/AuthRepository.dart';
import 'package:sina_mobile/service/repository/KelasRepository.dart';

import '../Model/user.dart';
import '../Model/kelas.dart';



class KelasViewModel extends ChangeNotifier {
  final KelasRepository repository;

  KelasViewModel({required this.repository});

  List<Datum> _kelasList = [];
  List<Datum> get kelasList => _kelasList;

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