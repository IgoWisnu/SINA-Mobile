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
      sakit: json['sakit'],
      izin: json['izin'],
      alpha: json['alpha'],
      hadir: json['hadir'],
    );
  }
}
