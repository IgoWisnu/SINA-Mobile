import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/DetailKelasResponse.dart';
import 'package:sina_mobile/Model/RekapAbsen.dart';
import 'package:sina_mobile/Model/StatistikSiswa.dart';
import 'package:sina_mobile/service/repository/AbsensiRepository.dart';
import 'package:sina_mobile/service/repository/StatistikRepository.dart';


class StatistikViewModel extends ChangeNotifier {
  final StatistikRepository repository;

  StatistikViewModel({required this.repository});

  DetailKelas? _detailKelas;
  bool _loading = false;
  String? _error;

  DetailKelas? get detailkelas => _detailKelas;
  bool get isLoading => _loading;
  String? get error => _error;

  StatistikData? _statistikData;
  StatistikData? get statistikdata => _statistikData;

  Future<void> getlistStatistik() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _detailKelas = await repository.fetchStatistik();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> getStatistik(
      String idAkademik
      ) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _statistikData = await repository.fetchStatistikDetail(idAkademik);
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }




}
