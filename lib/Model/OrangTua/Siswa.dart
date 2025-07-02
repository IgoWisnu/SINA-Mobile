class Siswa {
  final String nis;
  final String nisn;
  final String krsId;
  final String namaSiswa;
  final String noTelepon;
  final String fotoProfil;

  Siswa({
    required this.nis,
    required this.nisn,
    required this.krsId,
    required this.namaSiswa,
    required this.noTelepon,
    required this.fotoProfil,
  });

  factory Siswa.fromJson(Map<String, dynamic> json) {
    return Siswa(
      nis: json['nis']?.toString() ?? '',
      nisn: json['nisn']?.toString() ?? '',
      krsId: json['krs_id']?.toString() ?? '',
      namaSiswa: json['nama_siswa']?.toString() ?? '',
      noTelepon: json['no_telepon']?.toString() ?? '',
      fotoProfil: json['foto_profil']?.toString() ?? '',
    );
  }
}
