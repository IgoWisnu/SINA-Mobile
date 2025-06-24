class Nilai {
  final String mapelId;
  final String namaMapel;
  final int? nilaiPengetahuan;
  final int? nilaiKeterampilan;
  final int kkm;
  final int? nilaiAkhir;
  final String status;
  final String guruPengampu;

  Nilai({
    required this.mapelId,
    required this.namaMapel,
    this.nilaiPengetahuan,
    this.nilaiKeterampilan,
    required this.kkm,
    this.nilaiAkhir,
    required this.status,
    required this.guruPengampu,
  });

  factory Nilai.fromJson(Map<String, dynamic> json) {
    return Nilai(
      mapelId: json['mapel_id'],
      namaMapel: json['nama_mapel'],
      nilaiPengetahuan: json['nilai_pengetahuan'],
      nilaiKeterampilan: json['nilai_keterampilan'],
      kkm: json['kkm'],
      nilaiAkhir: json['nilai_akhir'],
      status: json['status'],
      guruPengampu: json['guru_pengampu'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mapel_id': mapelId,
      'nama_mapel': namaMapel,
      'nilai_pengetahuan': nilaiPengetahuan,
      'nilai_keterampilan': nilaiKeterampilan,
      'kkm': kkm,
      'nilai_akhir': nilaiAkhir,
      'status': status,
      'guru_pengampu': guruPengampu,
    };
  }
}