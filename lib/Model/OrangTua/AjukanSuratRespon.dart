class AjukanSuratResponse {
  final String message;
  final Map<String, dynamic>? data;

  AjukanSuratResponse({required this.message, this.data});

  factory AjukanSuratResponse.fromJson(Map<String, dynamic> json) {
    return AjukanSuratResponse(
      message: json['message']?.toString() ?? "Tidak ada pesan",
      data: json['data'],
    );
  }
}

class AjukanSuratData {
  final String nis;
  final String absensiId;
  final String tanggal;
  final String keterangan;

  AjukanSuratData({
    required this.nis,
    required this.absensiId,
    required this.tanggal,
    required this.keterangan,
  });

  factory AjukanSuratData.fromJson(Map<String, dynamic> json) {
    return AjukanSuratData(
      nis: json['nis'],
      absensiId: json['absensi_id'],
      tanggal: json['tanggal'],
      keterangan: json['keterangan'],
    );
  }
}
