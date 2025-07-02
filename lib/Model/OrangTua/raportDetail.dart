class NilaiMapel {
  final String namaMapel;
  final int nilai;
  final String kategori;

  NilaiMapel({
    required this.namaMapel,
    required this.nilai,
    required this.kategori,
  });

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
  final String kelas;
  final String semester;
  final List<NilaiMapel> nilai;
  final String lampiranUrl; // ✅ Tambahan
  String? downloadUrl; // ✅ Tambahan jika perlu,
  String? pdfUrl; // ✅ Tambahan jika perlu

  RaporDetail({
    required this.krsId,
    required this.nama,
    required this.kelas,
    required this.semester,
    required this.nilai,
    required this.lampiranUrl,
    this.downloadUrl, // ✅ Tambahan
    this.pdfUrl, // ✅ Tambahan
  });

  factory RaporDetail.fromJson(Map<String, dynamic> json) {
    final nilaiList =
        (json['nilai'] as List? ?? [])
            .map((item) => NilaiMapel.fromJson(item))
            .toList();

    return RaporDetail(
      krsId: json['krs_id'] ?? '',
      nama: json['nama'] ?? '',
      kelas: json['kelas'] ?? '',
      semester: json['semester'] ?? '',
      nilai: nilaiList,
      lampiranUrl: json['lampiranUrl'] ?? '',
      downloadUrl: json['downloadUrl'], // ✅ Tambahan jika perlu
      pdfUrl: json['pdfUrl'], // ✅ Tambahan jika perlu
    );
  }
}
