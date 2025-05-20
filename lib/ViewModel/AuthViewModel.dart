import 'package:flutter/material.dart';
import 'package:sina_mobile/service/repository/AuthRepository.dart';

import '../Model/user.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository repository;

  AuthViewModel({required this.repository});

  User? _user;
  bool _loading = false;
  String? _error;

  User? get user => _user;
  bool get isLoading => _loading;
  String? get error => _error;

  Future<bool> login(String email, String password) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _user = await repository.login(email, password);
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
