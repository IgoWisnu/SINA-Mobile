import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/RekapAbsen.dart';
import 'package:sina_mobile/Model/RiwayatSuratAbsenResponse.dart';
import 'package:sina_mobile/service/repository/AbsensiRepository.dart';

import '../Model/user.dart';

class RekapAbsensiViewModel extends ChangeNotifier {
  final AbsensiRepository repository;

  RekapAbsensiViewModel({required this.repository});

  RekapAbsenData? _rekapAbsenData;
  bool _loading = false;
  String? _error;

  RekapAbsenData? get rekapabsendata => _rekapAbsenData;
  bool get isLoading => _loading;
  String? get error => _error;

  List<SuratAbsen>? _suratAbsen;
  List<SuratAbsen>? get suratAbsen => _suratAbsen;

  Future<void> getRekapAbsen() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _rekapAbsenData = await repository.getRekapAbsen();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> getRiwayatAbsen() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _suratAbsen = await repository.getRekapData();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }


}
