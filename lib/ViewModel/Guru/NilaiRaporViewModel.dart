import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/Guru/NilaiRaporModel.dart';
import 'package:sina_mobile/service/repository/Guru/NilaiRepository.dart';

class NilaiRaporViewModel with ChangeNotifier {
  final NilaiRepository repository;

  // State variables
  List<Mapel> _mapelList = [];
  List<Kelas> _kelasList = [];
  List<SiswaNilai> _siswaList = [];
  Mapel? _selectedMapel;
  Kelas? _selectedKelas;
  bool _isLoading = false;
  String _errorMessage = '';

  // Getters
  List<Mapel> get mapelList => _mapelList;
  List<Kelas> get kelasList => _kelasList;
  List<SiswaNilai> get siswaList => _siswaList;
  Mapel? get selectedMapel => _selectedMapel;
  Kelas? get selectedKelas => _selectedKelas;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  NilaiRaporViewModel({required this.repository});

  // Fetch mapel yang diajar oleh guru
  Future<void> fetchMapel() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _mapelList = await repository.getMapelYangDiajar();

      if (_mapelList.isNotEmpty) {
        _selectedMapel = _mapelList.first;
        await fetchKelas();
      } else {
        _errorMessage = 'Tidak ada mata pelajaran yang diajar';
      }
    } catch (e) {
      _errorMessage = 'Gagal memuat mata pelajaran: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch kelas berdasarkan mapel yang dipilih
  Future<void> fetchKelas() async {
    if (_selectedMapel == null) return;

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _kelasList = await repository.getKelasByMapel(_selectedMapel!.mapelId);

      if (_kelasList.isNotEmpty) {
        _selectedKelas = _kelasList.first;
        await fetchSiswa();
      } else {
        _errorMessage = 'Tidak ada kelas untuk mata pelajaran ini';
      }
    } catch (e) {
      _errorMessage = 'Gagal memuat kelas: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch siswa berdasarkan mapel dan kelas
  Future<void> fetchSiswa() async {
    if (_selectedMapel == null || _selectedKelas == null) return;

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _siswaList = await repository.getSiswaByMapelKelas(
        _selectedMapel!.mapelId,
        _selectedKelas!.kelasId,
      );

      if (_siswaList.isEmpty) {
        _errorMessage = 'Tidak ada siswa dalam kelas ini';
      }
    } catch (e) {
      _errorMessage = 'Gagal memuat siswa: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Select mapel dan trigger fetch kelas
  void selectMapel(Mapel mapel) {
    _selectedMapel = mapel;
    _selectedKelas = null;
    _siswaList = [];
    fetchKelas();
  }

  // Select kelas dan trigger fetch siswa
  void selectKelas(Kelas kelas) {
    _selectedKelas = kelas;
    fetchSiswa();
  }

  // Submit nilai rapor
  Future<bool> submitNilai({
    required String krsId,
    required int nilai,
    required String status,
    required String mapelId,
  }) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final success = await repository.submitNilai(
        krsId: krsId,
        nilai: nilai,
        status: status,
        mapelId: mapelId,
      );

      if (success) {
        // Update local state
        final index = _siswaList.indexWhere((s) => s.krsId == krsId);
        if (index != -1) {
          _siswaList[index] = SiswaNilai(
            nis: _siswaList[index].nis,
            namaSiswa: _siswaList[index].namaSiswa,
            krsId: krsId,
            nilai: nilai,
            status: status,
          );
        }
        return true;
      }
      return false;
    } catch (e) {
      _errorMessage = 'Gagal menyimpan nilai: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
