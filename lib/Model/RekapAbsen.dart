class RekapAbsen {
  final int status;
  final RekapAbsenData data;

  RekapAbsen({
    required this.status,
    required this.data,
  });

  factory RekapAbsen.fromJson(Map<String, dynamic> json) {
    return RekapAbsen(
      status: json['status'],
      data: RekapAbsenData.fromJson(json['data']),
    );
  }
}

class RekapAbsenData {
  final int sakit;
  final int izin;
  final int alpha;
  final int hadir;

  RekapAbsenData({
    required this.sakit,
    required this.izin,
    required this.alpha,
    required this.hadir,
  });

  factory RekapAbsenData.fromJson(Map<String, dynamic> json) {
    return RekapAbsenData(
      sakit: int.tryParse(json['sakit'].toString()) ?? 0,
      izin: int.tryParse(json['izin'].toString()) ?? 0,
      alpha: int.tryParse(json['alpha'].toString()) ?? 0,
      hadir: int.tryParse(json['hadir'].toString()) ?? 0,
    );
  }
}

