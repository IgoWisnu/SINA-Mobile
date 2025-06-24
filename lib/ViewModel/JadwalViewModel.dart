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
      List<Jadwal> allJadwal = await repository.getJadwal();

      // Hilangkan duplikat berdasarkan start, finish, namaMapel, dan hari
      final seen = <String>{};
      _jadwalList = allJadwal.where((jadwal) {
        final key = '${jadwal.start}-${jadwal.finish}-${jadwal.namaMapel}-${jadwal.hari}';
        if (seen.contains(key)) {
          return false;
        } else {
          seen.add(key);
          return true;
        }
      }).toList();

    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }



}