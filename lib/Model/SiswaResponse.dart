class SiswaResponse {
  final String message;
  final int status;
  final Siswa siswa;

  SiswaResponse({
    required this.message,
    required this.status,
    required this.siswa,
  });

  factory SiswaResponse.fromJson(Map<String, dynamic> json) {
    return SiswaResponse(
      message: json['message'],
      status: json['status'],
      siswa: Siswa.fromJson(json['biodata']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'status': status, 'biodata': siswa.toJson()};
  }
}

class Siswa {
  final String nis;
  final String nama;
  final String tempatLahir;
  final DateTime tanggalLahir;
  final String alamat;
  final String kelas;
  final String tahunAkademik;

  Siswa({
    required this.nis,
    required this.nama,
    required this.tempatLahir,
    required this.tanggalLahir,
    required this.alamat,
    required this.kelas,
    required this.tahunAkademik,
  });

  factory Siswa.fromJson(Map<String, dynamic> json) {
    return Siswa(
      nis: json['nis'],
      nama: json['nama'],
      tempatLahir: json['tempat_lahir'],
      tanggalLahir: DateTime.parse(json['tanggal_lahir']),
      alamat: json['alamat'],
      kelas: json['kelas'],
      tahunAkademik: json['tahun_akademik'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nis': nis,
      'nama': nama,
      'tempat_lahir': tempatLahir,
      'tanggal_lahir': tanggalLahir.toIso8601String(),
      'alamat': alamat,
      'kelas': kelas,
      'tahun_akademik': tahunAkademik,
    };
  }
}
