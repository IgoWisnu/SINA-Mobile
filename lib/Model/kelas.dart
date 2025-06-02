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
  int mapelId;
  String namaKelas;
  String namaMapel;

  Datum({
    required this.mapelId,
    required this.namaKelas,
    required this.namaMapel,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      mapelId: int.parse(json['mapel_id'].toString()),
      namaKelas: json['nama_kelas'],
      namaMapel: json['nama_mapel'],
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
