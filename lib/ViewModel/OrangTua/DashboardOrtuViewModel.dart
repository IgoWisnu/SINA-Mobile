import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/OrangTua/DashboardOrtu.dart';
import 'package:sina_mobile/service/repository/OrangTua/DashboardOrtuRepository.dart';

class DashboardOrtuViewModel extends ChangeNotifier {
  final DashboardOrtuRepository repository;

  DashboardOrtuViewModel({required this.repository});

  DashboardStatus? _dashboardStatus;
  DashboardStatus? get dashboard => _dashboardStatus;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchDashboard(nis) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _dashboardStatus = await repository.fetchDashboard(nis);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
