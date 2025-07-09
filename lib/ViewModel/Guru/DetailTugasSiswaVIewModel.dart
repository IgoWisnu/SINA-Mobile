import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/Guru/Guru.dart';
import 'package:sina_mobile/service/repository/Guru/BiodataGuruRepository.dart';
import 'package:sina_mobile/service/repository/Guru/KelasGuruRepository.dart';


class DetailTugasSiswaViewModel extends ChangeNotifier {
  final KelasGuruRepository repository;

  DetailTugasSiswaViewModel({required this.repository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> updateProfilGuru(String idMapel, String idTugas, String krsId, String nilai) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await repository.updateNilai(idMapel: idMapel, idTugas: idTugas, krsID: krsId, nilai: nilai);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

}