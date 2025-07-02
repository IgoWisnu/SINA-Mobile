import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/OrangTua/StatistikOrtu.dart';
import 'package:sina_mobile/service/repository/OrangTua/StatistikNilaiRepository.dart';

class StatistikNilaiViewModel extends ChangeNotifier {
  final StatistikNilaiRepository repository;

  StatistikNilaiViewModel({required this.repository});

  StatistikOrtu? _statistikOrtu;
  bool _loading = false;
  String? _error;

  StatistikOrtu? get statistik => _statistikOrtu;
  bool get isLoading => _loading;
  String? get error => _error;

  Future<void> getStatistik() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _statistikOrtu = await repository.fetchStatistik();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
