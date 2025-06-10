import 'package:flutter/cupertino.dart';
import 'package:sina_mobile/Model/Guru/PengumpulanTugasResponse.dart';
import 'package:sina_mobile/service/api/ApiServiceGuru.dart';
import 'package:sina_mobile/service/repository/Guru/KelasGuruRepository.dart';

class Tambahmateriviewmodel with ChangeNotifier {
  final KelasGuruRepository repository = KelasGuruRepository(ApiServiceGuru());

  Future<void> tambahMateri({
    required String idMapel,
    required String judul,
    required String deskripsi,
    String? filePath,
  }) async {
    try {
      await repository.tambahMateri(
          idMapel: idMapel,
          judul: judul,
          deskripsi: deskripsi,
          filePath: filePath ?? ""
      );
    } catch (e) {
      rethrow; // dibiarkan naik ke UI untuk ditampilkan ke user
    }
  }

}
