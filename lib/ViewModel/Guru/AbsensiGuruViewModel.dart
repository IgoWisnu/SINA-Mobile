import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/Guru/DashboardGuru.dart';
import 'package:sina_mobile/Model/Guru/JadwalGuru.dart';
import 'package:sina_mobile/Model/Guru/ListSiswa.dart';
import 'package:sina_mobile/service/repository/AbsensiRepository.dart';
import 'package:sina_mobile/service/repository/Guru/AbsensiGuruRepository.dart';
import 'package:sina_mobile/service/repository/Guru/DashboardGuruRepository.dart';
import 'package:intl/intl.dart';

class AbsensiGuruViewModel extends ChangeNotifier {
  final AbsensiGuruRepository repository;

  AbsensiGuruViewModel({required this.repository});

  List<JadwalItem>? _jadwalItem;
  List<JadwalItem>? get jadwalitem => _jadwalItem;

  List<AbsensiSiswa>? _absensiSiswa;
  List<AbsensiSiswa>? get absensisiswa => _absensiSiswa;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchJadwal() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final allJadwal = await repository.fetchMapelHariIni();

      // Dapatkan nama hari saat ini (contoh: 'senin')
      final today = DateFormat('EEEE', 'id_ID').format(DateTime.now()).toLowerCase();

      // Filter berdasarkan hari ini dan unik berdasarkan mapel_id
      final seenMapel = <String>{};
      final filtered = allJadwal.where((jadwal) {
        final isToday = jadwal.hari.toLowerCase() == today;
        final isUnique = !seenMapel.contains(jadwal.mapelId);
        if (isToday && isUnique) {
          seenMapel.add(jadwal.mapelId);
          return true;
        }
        return false;
      }).toList();

      _jadwalItem = filtered;
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchSiswa(String idMapel) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _absensiSiswa = await repository.fetchSiswa(idMapel);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> kirimAbsensi(Map<String, dynamic> payload, String jadwalId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await repository.kirimAbsensi(payload, jadwalId);
      // handle jika perlu
      print("Absensi berhasil dikirim: $response");
    } catch (e) {
      print("Gagal mengirim absensi: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


}