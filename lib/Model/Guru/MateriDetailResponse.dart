class MateriDetailResponse {
  final bool success;
  final MateriDetailData data;

  MateriDetailResponse({
    required this.success,
    required this.data,
  });

  factory MateriDetailResponse.fromJson(Map<String, dynamic> json) {
    return MateriDetailResponse(
      success: json['success'],
      data: MateriDetailData.fromJson(json['data']),
    );
  }
}

class MateriDetailData {
  final MateriDetail detail;
  final List<MateriSiswa> siswa;

  MateriDetailData({
    required this.detail,
    required this.siswa,
  });

  factory MateriDetailData.fromJson(Map<String, dynamic> json) {
    return MateriDetailData(
      detail: MateriDetail.fromJson(json['detail']),
      siswa: (json['siswa'] as List)
          .map((e) => MateriSiswa.fromJson(e))
          .toList(),
    );
  }
}

class MateriDetail {
  final String materiId;
  final String namaMateri;
  final String uraian;
  final String lampiran;
  final DateTime createdAt;
  final String mapelId;
  final String namaMapel;
  final String kelasId;
  final String namaKelas;
  final int jumlahSiswa;

  MateriDetail({
    required this.materiId,
    required this.namaMateri,
    required this.uraian,
    required this.lampiran,
    required this.createdAt,
    required this.mapelId,
    required this.namaMapel,
    required this.kelasId,
    required this.namaKelas,
    required this.jumlahSiswa,
  });

  factory MateriDetail.fromJson(Map<String, dynamic> json) {
    return MateriDetail(
      materiId: json['materi_id'],
      namaMateri: json['nama_materi'],
      uraian: json['uraian'],
      lampiran: json['lampiran'],
      createdAt: DateTime.parse(json['created_at']),
      mapelId: json['mapel_id'],
      namaMapel: json['nama_mapel'],
      kelasId: json['kelas_id'],
      namaKelas: json['nama_kelas'],
      jumlahSiswa: json['jumlah_siswa'],
    );
  }
}

class MateriSiswa {
  final String nis;
  final String namaSiswa;
  final String krsId;
  final DateTime tanggalAkses;

  MateriSiswa({
    required this.nis,
    required this.namaSiswa,
    required this.krsId,
    required this.tanggalAkses,
  });

  factory MateriSiswa.fromJson(Map<String, dynamic> json) {
    return MateriSiswa(
      nis: json['nis'],
      namaSiswa: json['nama_siswa'],
      krsId: json['krs_id'],
      tanggalAkses: DateTime.parse(json['tanggal_akses']),
    );
  }
}

