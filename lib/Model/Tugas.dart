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
  final String tugasId;
  final String namaTugas;
  final String deskripsi;
  final String? lampiran;
  final String? uraian;
  final String? fileJawaban;
  final DateTime? createAt;
  final DateTime? tenggatKumpul;
  final DateTime? tanggalPengumpulan;
  final String? nilai;
  final String status;

  Tugas({
    required this.tugasId,
    required this.namaTugas,
    required this.deskripsi,
    this.lampiran,
    this.uraian,
    this.fileJawaban,
    this.createAt,
    this.tenggatKumpul,
    this.tanggalPengumpulan, // <-- HAPUS `required`
    this.nilai,
    required this.status
  });

  factory Tugas.fromJson(Map<String, dynamic> json) {
    return Tugas(
      tugasId: json['tugas_id'],
      namaTugas: json['nama_tugas'],
      deskripsi: json['deskripsi'],
      lampiran: json['lampiran'],
      uraian: json['uraian'],
      fileJawaban: json['file_jawaban'],
      createAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      tenggatKumpul: json['tenggat_kumpul'] != null ? DateTime.parse(json['tenggat_kumpul']) : null,
      tanggalPengumpulan: json['tanggal_pengumpulan'] != null
          ? DateTime.parse(json['tanggal_pengumpulan'])
          : null,
      nilai: json['nilai']?.toString(), // jika nilainya bisa null atau angka
      status: json['status']
    );
  }

  // ✅ Tambahkan named constructor untuk data dari dashboard
  factory Tugas.fromDashboardJson(Map<String, dynamic> json) {
    return Tugas(
      tugasId: json['id'],
      namaTugas: json['judul'],
      deskripsi: json['deskripsi'],
      lampiran: json['lampiran_guru'],
      uraian: json['uraian_jawaban'],
      fileJawaban: json['file_jawaban'],
      createAt: json['dibuat_pada'] != null ? DateTime.tryParse(json['dibuat_pada']) : null,
      tenggatKumpul: json['tenggat_kumpul'] != null ? DateTime.tryParse(json['tenggat_kumpul']) : null,
      tanggalPengumpulan: json['dikumpulkan_pada'] != null
          ? DateTime.tryParse(json['dikumpulkan_pada'])
          : null,
      nilai: json['nilai']?.toString(),
      status: json['status'],
    );
  }
}
