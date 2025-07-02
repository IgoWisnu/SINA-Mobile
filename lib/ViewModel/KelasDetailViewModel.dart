import 'package:flutter/cupertino.dart';
import 'package:sina_mobile/Model/JenisItem.dart';
import 'package:sina_mobile/Model/Tugas.dart';
import 'package:sina_mobile/service/repository/KelasRepository.dart';

class KelasDetailViewModel with ChangeNotifier {
  final KelasRepository repository;

  KelasDetailViewModel({required this.repository});

  List<KelasItem> _daftarGabungan = [];
  List<KelasItem> get daftarGabungan => _daftarGabungan;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchTugasMateri(String mapelId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final tugasList = await repository.fetchTugasByMapelId(mapelId);
      final materiList = await repository.fetchMateriByMapelId(mapelId);

      final allItems = <KelasItem>[
        ...tugasList.map((tugas) => KelasItem(
          jenis: JenisItem.tugas,
          judul: tugas.namaTugas,
          uploadDate: tugas.createAt ?? DateTime.now(),
          data: tugas,
        )),
        ...materiList.map((materi) => KelasItem(
          jenis: JenisItem.materi,
          judul: materi.namaMateri,
          uploadDate: materi.tanggalPengumpulan ?? DateTime.now(), // pastikan ini DateTime
          data: materi,
        )),
      ];

      allItems.sort((a, b) => b.uploadDate.compareTo(a.uploadDate));

      _daftarGabungan = allItems;
      _error = null;
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}

