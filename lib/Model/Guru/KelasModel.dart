class KelasModel {
  final String kelasId;
  final String namaKelas;

  KelasModel({required this.kelasId, required this.namaKelas});

  factory KelasModel.fromJson(Map<String, dynamic> json) {
    return KelasModel(kelasId: json['kelas_id'], namaKelas: json['nama_kelas']);
  }
}
