// lib/ViewModel/SuratIzinViewModel.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/Guru/SuratIzinModel.dart';
import '../../service/repository/Guru/SuratIzinRepository.dart';

class SuratIzinViewModel with ChangeNotifier {
  final SuratIzinRepository repository;
  bool _isSubmitting = false;

  List<SuratIzinModel> _suratIzinList = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<SuratIzinModel> get suratIzinList => _suratIzinList;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  SuratIzinViewModel({required this.repository});

  Future<void> fetchSuratIzin() async {
    _isLoading = true;
    notifyListeners();

    try {
      final newData = await repository.getSuratIzin();

      if (newData.isEmpty) {
        _suratIzinList = [];
        _errorMessage = 'Tidak ada surat izin yang perlu disetujui';
      } else {
        _suratIzinList = newData;
        _errorMessage = '';
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> approveLetter(String absensiId) async {
    try {
      final success = await repository.approveSuratIzin(absensiId);
      if (success) {
        // Tidak perlu fetch ulang karena data akan kosong setelah approve
        _suratIzinList.removeWhere((item) => item.absensiId == absensiId);
        if (_suratIzinList.isEmpty) {
          _errorMessage = 'Tidak ada surat izin yang perlu disetujui';
        }
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  Future<bool> showConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text('Konfirmasi'),
                content: Text('Anda yakin ingin menyetujui surat ini?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text('Batal'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text('Setujui'),
                  ),
                ],
              ),
        ) ??
        false;
  }
}
