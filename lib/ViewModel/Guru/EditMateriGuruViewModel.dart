import 'package:flutter/material.dart';
import 'package:sina_mobile/service/repository/Guru/KelasGuruRepository.dart';

class EditMateriGuruViewModel extends ChangeNotifier {
  final KelasGuruRepository repository;

  EditMateriGuruViewModel({required this.repository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> editMateri({
    required String idMateri,
    required String judul,
    required String deskripsi,
    String? filePath,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      await repository.editMateri(
          idMateri: idMateri,
          judul: judul,
          deskripsi: deskripsi,
          filePath: filePath ?? ""
      );
    } catch (e) {
      rethrow; // dibiarkan naik ke UI untuk ditampilkan ke user
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteMateri({
    required String idMateri
  }) async {
    _isLoading = true;
    notifyListeners();
    try{
      await repository.deleteMateri(
          idMateri: idMateri
      );
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }




}