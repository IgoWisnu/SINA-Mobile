import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/DashboardSiswa.dart';
import 'package:sina_mobile/Model/Guru/DashboardGuru.dart';
import 'package:sina_mobile/service/repository/DashboardRepository.dart';
import 'package:sina_mobile/service/repository/Guru/DashboardGuruRepository.dart';


class DashboardGuruViewModel extends ChangeNotifier {
  final DashboardGuruRepository repository;

  DashboardGuruViewModel({required this.repository});

  DashboardData? _dashboardData;
  DashboardData? get dashboard => _dashboardData;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchDashboard() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _dashboardData = await repository.fetchDashboard();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

}