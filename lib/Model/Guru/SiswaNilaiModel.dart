class SiswaNilaiModel {
  final String nis;
  final String namaSiswa;
  final String krsId;
  final int? nilai;
  final String status;

  SiswaNilaiModel({
    required this.nis,
    required this.namaSiswa,
    required this.krsId,
    this.nilai,
    required this.status,
  });

  factory SiswaNilaiModel.fromJson(Map<String, dynamic> json) {
    return SiswaNilaiModel(
      nis: json['nis'],
      namaSiswa: json['nama_siswa'],
      krsId: json['krs_id'],
      nilai: json['nilai'],
      status: json['status'] ?? 'Belum',
    );
  }
}
