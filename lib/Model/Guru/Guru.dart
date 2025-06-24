class Guru {
  final String nip;
  final String userId;
  final String namaGuru;
  final String alamat;
  final String noTelepon;
  final String agamaGuru;
  final String tempatLahirGuru;
  final String jenisKelaminGuru;
  final DateTime tanggalLahirGuru;
  final String fotoProfil;
  final DateTime createdAt;

  Guru({
    required this.nip,
    required this.userId,
    required this.namaGuru,
    required this.alamat,
    required this.noTelepon,
    required this.agamaGuru,
    required this.tempatLahirGuru,
    required this.jenisKelaminGuru,
    required this.tanggalLahirGuru,
    required this.fotoProfil,
    required this.createdAt,
  });

  factory Guru.fromJson(Map<String, dynamic> json) {
    return Guru(
      nip: json['nip'] ?? '',
      userId: json['user_id'] ?? '',
      namaGuru: json['nama_guru'] ?? '',
      alamat: json['alamat'] ?? '',
      noTelepon: json['no_telepon'] ?? '',
      agamaGuru: json['agama_guru'] ?? '',
      tempatLahirGuru: json['tempat_lahir_guru'] ?? '',
      jenisKelaminGuru: json['jenis_kelamin_guru'] ?? '',
      tanggalLahirGuru: json['tanggal_lahir_guru'] != null
          ? DateTime.parse(json['tanggal_lahir_guru'])
          : DateTime(2000), // fallback date
      fotoProfil: json['foto_profil'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime(2000),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nip': nip,
      'user_id': userId,
      'nama_guru': namaGuru,
      'alamat': alamat,
      'no_telepon': noTelepon,
      'agama_guru': agamaGuru,
      'tempat_lahir_guru': tempatLahirGuru,
      'jenis_kelamin_guru': jenisKelaminGuru,
      'tanggal_lahir_guru': tanggalLahirGuru.toIso8601String(),
      'foto_profil': fotoProfil,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
