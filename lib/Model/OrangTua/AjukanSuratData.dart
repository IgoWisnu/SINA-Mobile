class AjukanSuratData {
  final String? idSuratIzin;
  final String? nis;
  final String? absensiId;
  final String? tanggal;
  final String? keterangan;

  AjukanSuratData({
    this.idSuratIzin,
    this.nis,
    this.absensiId,
    this.tanggal,
    this.keterangan,
  });

  factory AjukanSuratData.fromJson(Map<String, dynamic> json) {
    return AjukanSuratData(
      idSuratIzin: json['id_surat_izin']?.toString(),
      nis: json['nis']?.toString(),
      absensiId: json['absensi_id']?.toString(),
      tanggal: json['tanggal']?.toString(),
      keterangan: json['keterangan']?.toString(),
    );
  }
}

class AjukanSuratResponse {
  final String message;
  final AjukanSuratData? data;

  AjukanSuratResponse({required this.message, this.data});

  factory AjukanSuratResponse.fromJson(Map<String, dynamic> json) {
    return AjukanSuratResponse(
      message: json['message']?.toString() ?? 'Gagal',
      data:
          json['data'] != null ? AjukanSuratData.fromJson(json['data']) : null,
    );
  }
}
