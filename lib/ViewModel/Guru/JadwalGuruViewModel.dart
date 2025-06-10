import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/Guru/JadwalGuru.dart';
import 'package:sina_mobile/Model/JadwalResponse.dart';
import 'package:sina_mobile/service/repository/Guru/JadwalGuruRepository.dart';
import 'package:sina_mobile/service/repository/JadwalRepository.dart';



class JadwalGuruViewModel extends ChangeNotifier {
  final JadwalGuruRepository repository;

  JadwalGuruViewModel({required this.repository});

  List<JadwalItem> _jadwalList = [];
  List<JadwalItem> get jadwalList => _jadwalList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchJadwal() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _jadwalList = await repository.getJadwal();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }


}