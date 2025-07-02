class DetailKelasOrtu {
  final String message;
  final int status;
  final DetailKelas data;

  DetailKelasOrtu({
    required this.message,
    required this.status,
    required this.data,
  });

  factory DetailKelasOrtu.fromJson(Map<String, dynamic> json) {
    return DetailKelasOrtu(
      message: json['message'],
      status: json['status'],
      data: DetailKelas.fromJson(json['data']),
    );
  }
}

class DetailKelas {
  final String id;
  final String namaKelas;
  final String tingkat;
  final String jenjang;
  final TahunAkademik tahunAkademik;
  final String kurikulum;
  final WaliKelas waliKelas;

  DetailKelas({
    required this.id,
    required this.namaKelas,
    required this.tingkat,
    required this.jenjang,
    required this.tahunAkademik,
    required this.kurikulum,
    required this.waliKelas,
  });

  factory DetailKelas.fromJson(Map<String, dynamic> json) {
    return DetailKelas(
      id: json['id'],
      namaKelas: json['nama_kelas'],
      tingkat: json['tingkat'],
      jenjang: json['jenjang'],
      tahunAkademik: TahunAkademik.fromJson(json['tahun_akademik']),
      kurikulum: json['kurikulum'],
      waliKelas: WaliKelas.fromJson(json['wali_kelas']),
    );
  }
}

class TahunAkademik {
  final String id;
  final String periode;
  final DateTime tahunMulai;
  final DateTime tahunBerakhir;
  final String status;

  TahunAkademik({
    required this.id,
    required this.periode,
    required this.tahunMulai,
    required this.tahunBerakhir,
    required this.status,
  });

  factory TahunAkademik.fromJson(Map<String, dynamic> json) {
    return TahunAkademik(
      id: json['id'],
      periode: json['periode'],
      tahunMulai: DateTime.parse(json['tahun_mulai']),
      tahunBerakhir: DateTime.parse(json['tahun_berakhir']),
      status: json['status'],
    );
  }
}

class WaliKelas {
  final String nama;
  final String fotoProfil;

  WaliKelas({required this.nama, required this.fotoProfil});

  factory WaliKelas.fromJson(Map<String, dynamic> json) {
    return WaliKelas(nama: json['nama'], fotoProfil: json['foto_profil']);
  }
}
