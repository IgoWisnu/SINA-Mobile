class Mapel {
  final String mapelId;
  final String namaMapel;

  Mapel({required this.mapelId, required this.namaMapel});

  factory Mapel.fromJson(Map<String, dynamic> json) {
    return Mapel(mapelId: json['mapel_id'], namaMapel: json['nama_mapel']);
  }
}

class Kelas {
  final String kelasId;
  final String namaKelas;

  Kelas({required this.kelasId, required this.namaKelas});

  factory Kelas.fromJson(Map<String, dynamic> json) {
    return Kelas(kelasId: json['kelas_id'], namaKelas: json['nama_kelas']);
  }
}

class SiswaNilai {
  final String nis;
  final String namaSiswa;
  final String krsId;
  final int? nilai;
  final String status;

  SiswaNilai({
    required this.nis,
    required this.namaSiswa,
    required this.krsId,
    this.nilai,
    required this.status,
  });

  factory SiswaNilai.fromJson(Map<String, dynamic> json) {
    return SiswaNilai(
      nis: json['nis'],
      namaSiswa: json['nama_siswa'],
      krsId: json['krs_id'],
      nilai: json['nilai'],
      status: json['status'] ?? 'belum',
    );
  }
}
