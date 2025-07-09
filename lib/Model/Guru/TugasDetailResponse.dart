import 'package:sina_mobile/Model/SiswaResponse.dart';

class TugasDetailResponse {
  final bool success;
  final TugasDetailData data;

  TugasDetailResponse({
    required this.success,
    required this.data,
  });

  factory TugasDetailResponse.fromJson(Map<String, dynamic> json) {
    return TugasDetailResponse(
      success: json['success'],
      data: TugasDetailData.fromJson(json['data']),
    );
  }
}

class TugasDetailData {
  final TugasDetail detail;

  TugasDetailData({
    required this.detail,
  });

  factory TugasDetailData.fromJson(Map<String, dynamic> json) {
    return TugasDetailData(
      detail: TugasDetail.fromJson(json['detail']),
    );
  }
}

class TugasDetail {
  final String? tugasId;
  final String? judul;
  final String? deskripsi;
  final String? lampiran;
  final DateTime? tenggatKumpul;
  final DateTime? createdAt;
  final String? mapelId;
  final String? namaMapel;
  final String? kelasId;
  final String? namaKelas;
  final int jumlahSiswa;
  final int jumlahDikumpulkan;
  final int jumlahTerlambat;

  TugasDetail({
    required this.tugasId,
    required this.judul,
    required this.deskripsi,
    required this.lampiran,
    required this.tenggatKumpul,
    required this.createdAt,
    required this.mapelId,
    required this.namaMapel,
    required this.kelasId,
    required this.namaKelas,
    required this.jumlahSiswa,
    required this.jumlahDikumpulkan,
    required this.jumlahTerlambat,
  });

  factory TugasDetail.fromJson(Map<String, dynamic> json) {
    return TugasDetail(
      tugasId: json['tugas_id']?.toString(),
      judul: json['judul']?.toString(),
      deskripsi: json['deskripsi']?.toString(),
      lampiran: json['lampiran']?.toString(),
      tenggatKumpul: json['tenggat_kumpul'] != null
          ? DateTime.tryParse(json['tenggat_kumpul'])
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      mapelId: json['mapel_id']?.toString(),
      namaMapel: json['nama_mapel']?.toString(),
      kelasId: json['kelas_id']?.toString(),
      namaKelas: json['nama_kelas']?.toString(),
      jumlahSiswa: json['jumlah_siswa'] is int
          ? json['jumlah_siswa']
          : int.tryParse(json['jumlah_siswa']?.toString() ?? '0') ?? 0,
      jumlahDikumpulkan:
      int.tryParse(json['jumlah_dikumpulkan']?.toString() ?? '0') ?? 0,
      jumlahTerlambat:
      int.tryParse(json['jumlah_terlambat']?.toString() ?? '0') ?? 0,
    );
  }
}

class Pengumpulan {
  final List<Siswa> sudahMengumpulkan;
  final List<Siswa> belumMengumpulkan;
  final int totalSudah;
  final int totalBelum;

  Pengumpulan({
    required this.sudahMengumpulkan,
    required this.belumMengumpulkan,
    required this.totalSudah,
    required this.totalBelum,
  });

  factory Pengumpulan.fromJson(Map<String, dynamic> json) {
    return Pengumpulan(
      sudahMengumpulkan: (json['sudah_mengumpulkan'] as List)
          .map((e) => Siswa.fromJson(e))
          .toList(),
      belumMengumpulkan: (json['belum_mengumpulkan'] as List)
          .map((e) => Siswa.fromJson(e))
          .toList(),
      totalSudah: json['total_sudah'],
      totalBelum: json['total_belum'],
    );
  }
}
