import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/Guru/Guru.dart';
import 'package:sina_mobile/Model/Guru/KelasGuru.dart';
import 'package:sina_mobile/Model/Guru/ListSiswa.dart';
import 'package:sina_mobile/Model/Guru/StatistikSiswaResponse.dart';
import 'package:sina_mobile/service/repository/Guru/StatistikGuruRepository.dart';


class StatistikGuruViewModel extends ChangeNotifier {
  final StatistikGuruRepository repository;

  StatistikGuruViewModel({required this.repository});

  List<KelasItem>? _listMapel;
  List<KelasItem>? get listmapel => _listMapel;

  List<StatistikGuru>? _statistikSiswa;
  List<StatistikGuru>? get statistiksiswa => _statistikSiswa;

  List<AbsensiSiswa>? _listSiswa;
  List<AbsensiSiswa>? get listsiwa => _listSiswa;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchKelas() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _listMapel = await repository.getKelas();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchListSiswa(
      String idMapel
      ) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
    _listSiswa = await repository.getListSiswa(idMapel);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchStatistik(
      String krsId
      ) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _statistikSiswa = await repository.getStatistikSiswa(krsId);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

}