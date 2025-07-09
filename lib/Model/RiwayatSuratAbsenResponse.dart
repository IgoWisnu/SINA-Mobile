class RiwayatSuratAbsenResponse {
  final String message;
  final int status;
  final List<SuratAbsen> data;

  RiwayatSuratAbsenResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory RiwayatSuratAbsenResponse.fromJson(Map<String, dynamic> json) {
    return RiwayatSuratAbsenResponse(
      message: json['message'],
      status: json['status'],
      data: List<SuratAbsen>.from(
        json['data'].map((item) => SuratAbsen.fromJson(item)),
      ),
    );
  }
}

class SuratAbsen {
  final String id;
  final String keterangan;
  final String tanggal;
  // final String mataPelajaran;
  // final String hari;
  // final String guru;
  final String alasan;
  final String? namaFile;
  final String? status;
  final String diajukanPada;
  final String? fileSurat;

  SuratAbsen({
    required this.id,
    required this.keterangan,
    required this.tanggal,
    // required this.mataPelajaran,
    // required this.hari,
    // required this.guru,
    required this.alasan,
    this.namaFile,
    this.status,
    required this.diajukanPada,
    this.fileSurat,
  });

  factory SuratAbsen.fromJson(Map<String, dynamic> json) {
    return SuratAbsen(
      id: json['id'],
      keterangan: json['keterangan'],
      tanggal: json['tanggal'],
      // mataPelajaran: json['mata_pelajaran'],
      // hari: json['hari'],
      // guru: json['guru'],
      alasan: json['alasan'],
      namaFile: json['nama_file'],
      status: json['status'],
      diajukanPada: json['diajukan_pada'],
      fileSurat: json['file_surat'],
    );
  }
}
