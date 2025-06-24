import 'package:flutter/material.dart';
import 'package:sina_mobile/service/repository/BeritaRepository.dart';
import 'package:sina_mobile/Model/Berita.dart';
import 'package:sina_mobile/service/repository/Guru/BeritaGuruRepository.dart';


class PengumumanGuruViewModel extends ChangeNotifier {
  final BeritaGuruRepository repository;

  PengumumanGuruViewModel({required this.repository});

  List<Berita> _beritaList = [];
  List<Berita> get beritaList => _beritaList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchBerita() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _beritaList = await repository.getBerita();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> tambahBerita({
    required String judul,
    required String deskripsi,
    String? filePath,
  }) async {
    try {
      await repository.tambahBerita(
          judul: judul,
          deskripsi: deskripsi,
          filePath: filePath ?? ""
      );
    } catch (e) {
      rethrow; // dibiarkan naik ke UI untuk ditampilkan ke user
    }
  }

  Future<void> editBerita({
    required String idBerita,
    required String judul,
    required String deskripsi,
    String? filePath,
  }) async {
    try {
      await repository.editBerita(
          id : idBerita,
          judul: judul,
          deskripsi: deskripsi,
          filePath: filePath ?? ""
      );
    } catch (e) {
      rethrow; // dibiarkan naik ke UI untuk ditampilkan ke user
    }
  }

  Future<void> deleteBerita({
    required String idBerita
  }) async {
    try{
      await repository.deleteBerita(
          idBerita
      );
    } catch (e) {
      rethrow;
    }
  }




}