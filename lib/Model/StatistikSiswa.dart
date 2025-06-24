class StatistikSiswa {
  final String message;
  final int status;
  final StatistikData data;

  StatistikSiswa({
    required this.message,
    required this.status,
    required this.data,
  });

  factory StatistikSiswa.fromJson(Map<String, dynamic> json) {
    return StatistikSiswa(
      message: json['message'],
      status: json['status'],
      data: StatistikData.fromJson(json['data']),
    );
  }
}

class StatistikData {
  final String tahunAkademikId;
  final StatistikUmum statistikUmum;
  final List<DetailNilai> detailNilai;

  StatistikData({
    required this.tahunAkademikId,
    required this.statistikUmum,
    required this.detailNilai,
  });

  factory StatistikData.fromJson(Map<String, dynamic> json) {
    return StatistikData(
      tahunAkademikId: json['tahun_akademik_id'],
      statistikUmum: StatistikUmum.fromJson(json['statistik_umum']),
      detailNilai: List<DetailNilai>.from(
        json['detail_nilai'].map((x) => DetailNilai.fromJson(x)),
      ),
    );
  }
}

class StatistikUmum {
  final int totalMapel;
  final int totalTuntas;
  final int totalBelumTuntas;
  final int rataRataNilai;
  final int rataRataKeterampilan;
  final int rataRataNilaiAkhir;

  StatistikUmum({
    required this.totalMapel,
    required this.totalTuntas,
    required this.totalBelumTuntas,
    required this.rataRataNilai,
    required this.rataRataKeterampilan,
    required this.rataRataNilaiAkhir,
  });

  factory StatistikUmum.fromJson(Map<String, dynamic> json) {
    return StatistikUmum(
      totalMapel: json['total_mapel'],
      totalTuntas: json['total_tuntas'],
      totalBelumTuntas: json['total_belum_tuntas'],
      rataRataNilai: json['rata_rata_nilai'],
      rataRataKeterampilan: json['rata_rata_keterampilan'],
      rataRataNilaiAkhir: json['rata_rata_nilai_akhir'],
    );
  }
}

class DetailNilai {
  final String mapelId;
  final String namaMapel;
  final int? nilaiPengetahuan;
  final int? nilaiKeterampilan;
  final int? nilaiAkhir;
  final int kkm;
  final String status;

  DetailNilai({
    required this.mapelId,
    required this.namaMapel,
    this.nilaiPengetahuan,
    this.nilaiKeterampilan,
    this.nilaiAkhir,
    required this.kkm,
    required this.status,
  });

  factory DetailNilai.fromJson(Map<String, dynamic> json) {
    return DetailNilai(
      mapelId: json['mapel_id'].toString(),
      namaMapel: json['nama_mapel'],
      nilaiPengetahuan: json['nilai_pengetahuan'],
      nilaiKeterampilan: json['nilai_keterampilan'],
      nilaiAkhir: json['nilai_akhir'],
      kkm: json['kkm'],
      status: json['status'],
    );
  }
}
