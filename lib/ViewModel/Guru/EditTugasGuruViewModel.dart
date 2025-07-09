import 'package:flutter/material.dart';
import 'package:sina_mobile/service/repository/BeritaRepository.dart';
import 'package:sina_mobile/Model/Berita.dart';
import 'package:sina_mobile/service/repository/Guru/BeritaGuruRepository.dart';
import 'package:sina_mobile/service/repository/Guru/KelasGuruRepository.dart';


class EditTugasGuruViewModel extends ChangeNotifier {
  final KelasGuruRepository repository;

  EditTugasGuruViewModel({required this.repository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> editTugas({
    required String idTugas,
    required String judul,
    required String deskripsi,
    required String tenggat,
    String? filePath,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      await repository.editTugas(
          idTugas: idTugas,
          judul: judul,
          deskripsi: deskripsi,
          tenggat: tenggat,
        filePath: filePath,
      );
    } catch (e) {
      rethrow; // dibiarkan naik ke UI untuk ditampilkan ke user
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteTugas({
    required String idTugas
  }) async {
    _isLoading = true;
    notifyListeners();
    try{
      await repository.deleteTugas(
          idTugas: idTugas
      );
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }





}