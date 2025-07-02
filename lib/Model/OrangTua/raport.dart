class Rapor {
  final String krsId;
  final String namaKelas;

  Rapor({required this.krsId, required this.namaKelas});

  factory Rapor.fromJson(Map<String, dynamic> json) {
    return Rapor(
      krsId: json['krs_id'] ?? '',
      namaKelas: json['nama_kelas'] ?? '',
    );
  }
}

class RaporSiswa {
  final String nis;
  final String nama;
  final List<Rapor> riwayatRapor;

  RaporSiswa({
    required this.nis,
    required this.nama,
    required this.riwayatRapor,
  });

  factory RaporSiswa.fromJson(Map<String, dynamic> json) {
    var raporList = json['riwayat_rapor'] as List? ?? [];
    List<Rapor> riwayat =
        raporList.map((rapor) => Rapor.fromJson(rapor)).toList();

    return RaporSiswa(
      nis: json['nis'] ?? '',
      nama: json['nama'] ?? '',
      riwayatRapor: riwayat,
    );
  }
}
