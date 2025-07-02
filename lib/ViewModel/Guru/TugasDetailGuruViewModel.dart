import 'package:flutter/cupertino.dart';
import 'package:sina_mobile/Model/Guru/PengumpulanTugasResponse.dart';
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

}
