import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/Model/OrangTua/RekapAbsenOrtu.dart';
import 'package:sina_mobile/service/repository/OrangTua/AbsensiOrtuRepository.dart';

class RekapAbsensiOrtuViewModel extends ChangeNotifier {
  final AbsensiOrtuRepository repository;

  RekapAbsensiOrtuViewModel({required this.repository});

  RekapAbsenData? _rekapAbsenData;
  bool _loading = false;
  String? _error;

  RekapAbsenData? get rekapabsendata => _rekapAbsenData;
  bool get isLoading => _loading;
  String? get error => _error;

  Future<void> getRekapAbsen() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final nis = prefs.getString('nis') ?? '';
      final krsId = prefs.getString('krs_id') ?? '';

      if (nis.isEmpty || krsId.isEmpty) {
        throw Exception("NIS atau KRS ID tidak tersedia");
      }

      _rekapAbsenData = await repository.getRekapAbsen(nis, krsId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
