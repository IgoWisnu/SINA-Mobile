class MateriDetail {
  final int status;
  final List<Materi> data;

  MateriDetail({
    required this.status,
    required this.data,
  });

  factory MateriDetail.fromJson(Map<String, dynamic> json) {
    return MateriDetail(
      status: json['status'],
      data: List<Materi>.from(json['data'].map((x) => Materi.fromJson(x))),
    );
  }
}

class Materi {
  final int materiId;
  final String namaMateri;
  final String deskripsi;
  final String? lampiran;
  final DateTime tanggalPengumpulan;

  Materi({
    required this.materiId,
    required this.namaMateri,
    required this.deskripsi,
    this.lampiran,
    required this.tanggalPengumpulan,
  });

  factory Materi.fromJson(Map<String, dynamic> json) {
    return Materi(
      materiId: int.parse(json['materi_id'].toString()),
      namaMateri: json['nama_materi'],
      deskripsi: json['uraian'],
      lampiran: json['lampiran'],
      tanggalPengumpulan: DateTime.parse(json['created_at']),
    );
  }
}
