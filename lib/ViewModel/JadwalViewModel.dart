import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/JadwalResponse.dart';
import 'package:sina_mobile/service/repository/AuthRepository.dart';
import 'package:sina_mobile/service/repository/JadwalRepository.dart';
import 'package:sina_mobile/service/repository/KelasRepository.dart';
import '../Model/user.dart';
import '../Model/kelas.dart';

class JadwalViewModel extends ChangeNotifier {
  final JadwalRepository repository;

  JadwalViewModel({required this.repository});

  List<Jadwal> _jadwalList = [];
  List<Jadwal> get jadwalList => _jadwalList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchJadwal() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _jadwalList = await repository.getJadwal();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
