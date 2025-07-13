class NilaiMapel {
  final String namaMapel;
  final double? nilai;
  final String kategori;

  NilaiMapel({required this.namaMapel, this.nilai, required this.kategori});

  factory NilaiMapel.fromJson(Map<String, dynamic> json) {
    return NilaiMapel(
      namaMapel: json['nama_mapel'] ?? '',
      nilai: json['nilai'] ?? 0,
      kategori: json['kategori'] ?? '',
    );
  }
}

class RaporDetail {
  final String krsId;
  final String nama;
  final String nis;
  final String? kelas;
  final String semester;
  final List<NilaiMapel> nilai;
  final String lampiranUrl;
  final String downloadUrl;
  final String pdfUrl;

  RaporDetail({
    required this.krsId,
    required this.nama,
    required this.nis,
    this.kelas,
    required this.semester,
    required this.nilai,
    required this.lampiranUrl,
    required this.downloadUrl,
    required this.pdfUrl,
  });

  factory RaporDetail.fromJson(Map<String, dynamic> json) {
    final nilaiList =
        (json['nilai'] as List? ?? [])
            .map((item) => NilaiMapel.fromJson(item))
            .toList();

    return RaporDetail(
      krsId: json['krs_id']?.toString() ?? '',
      nama: json['nama']?.toString() ?? '',
      nis: json['nis']?.toString() ?? '',
      kelas: json['kelas']?.toString(),
      semester: json['semester']?.toString() ?? '',
      nilai: nilaiList,
      lampiranUrl: json['lampiranUrl']?.toString() ?? '',
      downloadUrl: json['downloadUrl']?.toString() ?? '',
      pdfUrl: json['pdfUrl']?.toString() ?? '',
    );
  }
}
