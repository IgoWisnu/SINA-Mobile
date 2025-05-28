class KelasDetail {
  final int status;
  final List<Tugas> data;

  KelasDetail({
    required this.status,
    required this.data,
  });

  factory KelasDetail.fromJson(Map<String, dynamic> json) {
    return KelasDetail(
      status: json['status'],
      data: List<Tugas>.from(json['data'].map((x) => Tugas.fromJson(x))),
    );
  }
}

class Tugas {
  final int tugasId;
  final String namaTugas;
  final String deskripsi;
  final String? lampiran;
  final String? uraian;
  final String? fileJawaban;
  final String? tenggatKumpul;
  final DateTime tanggalPengumpulan;
  final String? nilai;

  Tugas({
    required this.tugasId,
    required this.namaTugas,
    required this.deskripsi,
    this.lampiran,
    this.uraian,
    this.fileJawaban,
    this.tenggatKumpul,
    required this.tanggalPengumpulan,
    this.nilai,
  });

  factory Tugas.fromJson(Map<String, dynamic> json) {
    return Tugas(
      tugasId: json['tugas_id'],
      namaTugas: json['judul'],
      deskripsi: json['deskripsi'],
      lampiran: json['lampiran'],
      uraian: json['uraian'],
      fileJawaban: json['file_jawaban'],
      tenggatKumpul: json['tenggat_kumpul'],
      tanggalPengumpulan: DateTime.parse(json['tanggal_pengumpulan']),
      nilai: json['nilai']?.toString(), // jika nilainya bisa null atau angka
    );
  }
}
