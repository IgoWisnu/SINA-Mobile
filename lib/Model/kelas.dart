class Kelas {
  int status;
  List<Datum> data;

  Kelas({
    required this.status,
    required this.data,
  });

  factory Kelas.fromJson(Map<String, dynamic> json) {
    return Kelas(
      status: json['status'],
      data: List<Datum>.from(json['data'].map((x) => Datum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': List<dynamic>.from(data.map((x) => x.toJson())),
    };
  }
}

class Datum {
  String mapelId;
  String namaKelas;
  String namaMapel;
  String namaGuru;
  String fotoProfil;

  Datum({
    required this.mapelId,
    required this.namaKelas,
    required this.namaMapel,
    required this.namaGuru,
    required this.fotoProfil
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      mapelId: json['mapel_id'],
      namaKelas: json['nama_kelas'],
      namaMapel: json['nama_mapel'],
      namaGuru: json['nama_guru'],
      fotoProfil: json['foto_profil'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mapel_id': mapelId,
      'nama_kelas': namaKelas,
      'nama_mapel': namaMapel,
    };
  }
}
