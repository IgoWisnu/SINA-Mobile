class DetailSuratIzin {
  final String absensiId;
  final String namaSiswa;
  final String tanggal;
  final String jenis;
  final String uraian;
  final String status;
  final String suratUrl;

  DetailSuratIzin({
    required this.absensiId,
    required this.namaSiswa,
    required this.tanggal,
    required this.jenis,
    required this.uraian,
    required this.status,
    required this.suratUrl,
  });

  factory DetailSuratIzin.fromJson(Map<String, dynamic> json) {
    return DetailSuratIzin(
      absensiId: json['absensi_id'] ?? '',
      namaSiswa: json['nama_siswa'] ?? '',
      tanggal: json['tanggal'] ?? '',
      jenis: json['jenis'] ?? '',
      uraian: json['uraian'] ?? '',
      status: json['status'] ?? '',
      suratUrl: json['surat_url'] ?? '',
    );
  }
}
