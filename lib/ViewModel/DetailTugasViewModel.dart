

import 'package:flutter/cupertino.dart';
import 'package:sina_mobile/service/api/ApiService.dart';
import 'package:sina_mobile/service/repository/KelasRepository.dart';

class Detailtugasviewmodel with ChangeNotifier {
  final KelasRepository repository = KelasRepository(ApiService());

  Future<void> kumpulkanTugas({
    required int idTugas,
    required String filePath,
    required String deskripsi,
  }) async {
    try {
      await repository.kumpulkanTugas(
        idTugas: idTugas,
        filePath: filePath,
        deskripsi: deskripsi,
      );
    } catch (e) {
      rethrow; // dibiarkan naik ke UI untuk ditampilkan ke user
    }
  }
}
