class RekapAbsenOrtu {
  final int status;
  final RekapAbsenData data;

  RekapAbsenOrtu({required this.status, required this.data});

  factory RekapAbsenOrtu.fromJson(Map<String, dynamic> json) {
    return RekapAbsenOrtu(
      status: json['status'] ?? 200, // Atur default 200 kalau tidak tersedia
      data: RekapAbsenData.fromJson(json['data'] ?? {}),
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
    final absensi = json['absensi'] ?? {}; // Ambil dari sub-key 'absensi'
    return RekapAbsenData(
      sakit: int.tryParse(absensi['sakit']?.toString() ?? '0') ?? 0,
      izin: int.tryParse(absensi['izin']?.toString() ?? '0') ?? 0,
      alpha: int.tryParse(absensi['alpha']?.toString() ?? '0') ?? 0,
      hadir: int.tryParse(absensi['hadir']?.toString() ?? '0') ?? 0,
    );
  }
}
