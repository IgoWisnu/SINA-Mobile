class JadwalResponse {
  final String message;
  final int status;
  final List<Jadwal> jadwalPelajaran;

  JadwalResponse({
    required this.message,
    required this.status,
    required this.jadwalPelajaran,
  });

  factory JadwalResponse.fromJson(Map<String, dynamic> json) {
    return JadwalResponse(
      message: json['message'],
      status: json['status'],
      jadwalPelajaran: List<Jadwal>.from(
        json['jadwal_pelajaran'].map((x) => Jadwal.fromJson(x)),
      ),
    );
  }
}

class Jadwal {
  final int hari;
  final String start;
  final String finish;
  final String namaMapel;
  final String namaGuru;

  Jadwal({
    required this.hari,
    required this.start,
    required this.finish,
    required this.namaMapel,
    required this.namaGuru,
  });

  factory Jadwal.fromJson(Map<String, dynamic> json) {
    return Jadwal(
      hari: json['hari'],
      start: json['start'],
      finish: json['finish'],
      namaMapel: json['nama_mapel'],
      namaGuru: json['nama_guru'],
    );
  }
}
