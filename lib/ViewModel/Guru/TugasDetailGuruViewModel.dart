import 'package:flutter/cupertino.dart';
import 'package:sina_mobile/Model/Guru/PengumpulanTugasResponse.dart';
import 'package:sina_mobile/Model/Guru/TugasDetailResponse.dart';
import 'package:sina_mobile/Model/Guru/TugasGuru.dart';
import 'package:sina_mobile/service/api/ApiServiceGuru.dart';
import 'package:sina_mobile/service/repository/Guru/KelasGuruRepository.dart';

class TugasDetailGuruViewModel with ChangeNotifier {
  final KelasGuruRepository repository = KelasGuruRepository(ApiServiceGuru());

  List<SudahMengumpulkan> _siswaMengumpulkanList = [];
  List<SudahMengumpulkan> get kelasList => _siswaMengumpulkanList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchSiswaMengumpulkan({
    required String idMapel,
    required String idTugas,
}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _siswaMengumpulkanList =
      await repository.fetchSiwaMengumpulkan(
          idMapel,
          idTugas
      );
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> tambahTugas({
    required String idMapel,
    required String judul,
    required String deskripsi,
    required String tenggat,
    String? filePath,
  }) async {
    try {
      await repository.tambahTugas(
        idMapel: idMapel,
        judul: judul,
        deskripsi: deskripsi,
        tenggat: tenggat,
        filePath: filePath ?? ""
      );
    } catch (e) {
      rethrow; // dibiarkan naik ke UI untuk ditampilkan ke user
    }
  }


  Future<TugasDetail> getDetailTugas({
    required String idTugas,
  }) async {
    try {
      TugasDetail item = await repository.getDetailTugas(idTugas: idTugas);
      print('item : $item');
      return item;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getDetailMateri({
    required String idMateri
  }) async {
    try {
      await repository.getDetailMateri(
        idMateri : idMateri,
      );
    } catch (e) {
      rethrow; // dibiarkan naik ke UI untuk ditampilkan ke user
    }
  }

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
          filePath: filePath ?? ""
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
