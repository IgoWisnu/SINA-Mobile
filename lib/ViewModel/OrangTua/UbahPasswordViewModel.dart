import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/OrangTua/UpdatePasswordRequest.dart';
import 'package:sina_mobile/service/repository/OrangTua/UbahPasswordRepository.dart';

class UbahPasswordViewModel extends ChangeNotifier {
  final UbahPasswordRepository repository;

  UbahPasswordViewModel({required this.repository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> ubahPassword(UpdatePasswordRequest request) async {
    _isLoading = true;
    notifyListeners();

    try {
      await repository.ubahPassword(request);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
