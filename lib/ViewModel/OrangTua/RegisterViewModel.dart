// ✅ FINAL CODE: RegisterViewModel.dart
import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/OrangTua/RegisterInitResponse.dart';
import 'package:sina_mobile/service/repository/OrangTua/RegisterRepository.dart';

class RegisterViewModel extends ChangeNotifier {
  final RegisterRepository repository;
  RegisterViewModel({required this.repository});

  bool _isLoading = false;
  String? _errorMessage;
  RegisterData? _registerData;
  String? _registrationToken;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  RegisterData? get registerData => _registerData;
  String? get registrationToken => _registrationToken;

  /// Memulai registrasi awal untuk mendapatkan nama siswa dan orang tua
  Future<void> startRegistration(String nis, String statusOrtu) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await repository.startRegistration(nis, statusOrtu);
      _registerData = response.data;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Verifikasi OTP dan simpan token registrasi
  Future<bool> validateOtp({
    required String nis,
    required String statusOrtu,
    required String otp,
    required String email,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _registrationToken = await repository.validateOtpOnly(
        nis: nis,
        statusOrtu: statusOrtu,
        otp: otp,
        email: email,
      );
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Menyelesaikan registrasi dengan password dan token
  Future<bool> completeRegistration({
    required String password,
    required String confirmPassword,
    required String imei,
  }) async {
    if (_registrationToken == null) {
      _errorMessage =
          "Token registrasi tidak ditemukan. Silakan ulangi proses registrasi.";
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await repository.completeRegistration(
        password: password,
        confirmPassword: confirmPassword,
        imei: imei,
        registrationToken: _registrationToken!,
      );
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
