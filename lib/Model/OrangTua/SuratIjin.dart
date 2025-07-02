class SuratIzin {
  final String id;
  final String jenis;
  final String tanggal;
  final String status;

  SuratIzin({
    required this.id,
    required this.jenis,
    required this.tanggal,
    required this.status,
  });

  factory SuratIzin.fromJson(Map<String, dynamic> json) {
    return SuratIzin(
      id: json['id']?.toString() ?? '',
      jenis: json['jenis']?.toString() ?? '',
      tanggal: json['tanggal']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
    );
  }
}
