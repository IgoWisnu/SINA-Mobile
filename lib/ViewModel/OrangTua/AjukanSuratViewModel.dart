import 'package:flutter/foundation.dart';
import 'package:sina_mobile/Model/OrangTua/AjukanSuratData.dart';
import 'package:sina_mobile/service/repository/OrangTua/AjukanSuratRepository.dart';

class AjukanSuratViewModel extends ChangeNotifier {
  final AjukanSuratRepository repository;

  AjukanSuratViewModel({required this.repository});

  bool isLoading = false;
  String? errorMessage;

  Future<AjukanSuratResponse> submitSurat({
    required String nis,
    required String keterangan,
    required String uraian,
    required String tanggalAbsensi,
    required String filePath,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await repository.ajukanSurat(
        nis: nis,
        keterangan: keterangan,
        uraian: uraian,
        tanggalAbsensi: tanggalAbsensi,
        filePath: filePath,
      );
      errorMessage = null;
      return response;
    } catch (e) {
      errorMessage = e.toString();
      throw Exception(errorMessage);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
