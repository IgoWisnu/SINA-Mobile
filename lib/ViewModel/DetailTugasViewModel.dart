

import 'package:flutter/cupertino.dart';
import 'package:sina_mobile/service/api/ApiService.dart';
import 'package:sina_mobile/service/repository/KelasRepository.dart';

class Detailtugasviewmodel with ChangeNotifier {
  final KelasRepository repository = KelasRepository(ApiService());

  Future<void> kumpulkanTugass({
    required String tugasId,
    required String filePath,
    required String deskripsi,
  }) async {
    try {
      await repository.kumpulkanTugas(
        idTugas: tugasId,
        filePath: filePath,
        deskripsi: deskripsi,
      );
    } catch (e) {
      rethrow; // dibiarkan naik ke UI untuk ditampilkan ke user
    }
  }
}
