import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/DashboardSiswa.dart';
import 'package:sina_mobile/Model/Guru/DashboardCountRespone.dart';
import 'package:sina_mobile/Model/Guru/DashboardGuru.dart';
import 'package:sina_mobile/Model/Tugas.dart';
import 'package:sina_mobile/service/repository/DashboardRepository.dart';
import 'package:sina_mobile/service/repository/Guru/DashboardGuruRepository.dart';


class DashboardGuruViewModel extends ChangeNotifier {
  final DashboardGuruRepository repository;

  DashboardGuruViewModel({required this.repository});

  final Map<String, DashboardGuruData> _mapelDataMap = {};
  List<String> _mapelList = [];
  String? _selectedMapel;

  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  List<String> get mapelList => _mapelList;
  String? get selectedMapel => _selectedMapel;

  List<Tugas> _tugasTerbaru = [];
  List<Tugas> get tugasTerbaru => _tugasTerbaru;
  DashboardGuruData? get dashboard => _selectedMapel != null ? _mapelDataMap[_selectedMapel] : null;

  Future<void> fetchDashboard() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final dataMap = await repository.fetchDashboardGuru();

      _mapelDataMap.clear();
      _mapelList.clear();

      for (var mapel in dataMap.keys) {
        _mapelList.add(mapel);
        _mapelDataMap[mapel] = dataMap[mapel]!;
      }

      if (_mapelList.isNotEmpty) {
        _selectedMapel = _mapelList.first;
      }

    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void setSelectedMapel(String mapel) {
    _selectedMapel = mapel;
    notifyListeners();
  }
}