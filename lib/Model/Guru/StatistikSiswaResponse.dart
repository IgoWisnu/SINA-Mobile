class StatistikGuruResponse {
  final bool success;
  final List<StatistikGuru> data;

  StatistikGuruResponse({
    required this.success,
    required this.data,
  });

  factory StatistikGuruResponse.fromJson(Map<String, dynamic> json) {
    return StatistikGuruResponse(
      success: json['success'],
      data: (json['data'] as List)
          .map((item) => StatistikGuru.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class StatistikGuru {
  final String namaMapel;
  final int nilai;
  final DateTime tahunMulai;
  final String tingkat;

  StatistikGuru({
    required this.namaMapel,
    required this.nilai,
    required this.tahunMulai,
    required this.tingkat,
  });

  factory StatistikGuru.fromJson(Map<String, dynamic> json) {
    return StatistikGuru(
      namaMapel: json['nama_mapel'],
      nilai: json['nilai'],
      tahunMulai: DateTime.parse(json['tahun_mulai']),
      tingkat: json['tingkat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_mapel': namaMapel,
      'nilai': nilai,
      'tahun_mulai': tahunMulai.toIso8601String(),
      'tingkat': tingkat,
    };
  }
}
