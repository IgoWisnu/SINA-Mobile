class NilaiMapelBaru {
  final String namaMapel;
  final double? pengetahuan;
  final double? keterampilan;
  final int kkm;
  final String status;
  final String? guruPengampu;

  NilaiMapelBaru({
    required this.namaMapel,
    this.pengetahuan,
    this.keterampilan,
    required this.kkm,
    required this.status,
    this.guruPengampu,
  });

  factory NilaiMapelBaru.fromJson(Map<String, dynamic> json) {
    return NilaiMapelBaru(
      namaMapel: json['nama_mapel'] ?? '',
      pengetahuan: (json['pengetahuan'] as num?)?.toDouble(),
      keterampilan: (json['keterampilan'] as num?)?.toDouble(),
      kkm: json['kkm'] ?? 0,
      status: json['status'] ?? '',
      guruPengampu: json['guru_pengampu'],
    );
  }
}

class RaporFileResponse {
  final String nis;
  final String raporUrl;
  final String filename;
  final String timestamp;
  final List<NilaiMapelBaru> nilai;

  RaporFileResponse({
    required this.nis,
    required this.raporUrl,
    required this.filename,
    required this.timestamp,
    required this.nilai,
  });

  factory RaporFileResponse.fromJson(Map<String, dynamic> json) {
    final nilaiList =
        (json['data']['nilai'] as List<dynamic>)
            .map((item) => NilaiMapelBaru.fromJson(item))
            .toList();

    return RaporFileResponse(
      nis: json['nis'] ?? '',
      raporUrl: json['rapor_url'] ?? '',
      filename: json['filename'] ?? '',
      timestamp: json['timestamp'] ?? '',
      nilai: nilaiList,
    );
  }
}
