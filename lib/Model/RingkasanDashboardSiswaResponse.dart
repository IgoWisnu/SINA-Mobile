class RingkasanDashboardSiswaResponse {
  final String message;
  final int status;
  final RingkasanDashboardData data;

  RingkasanDashboardSiswaResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory RingkasanDashboardSiswaResponse.fromJson(Map<String, dynamic> json) {
    return RingkasanDashboardSiswaResponse(
      message: json['message'],
      status: json['status'],
      data: RingkasanDashboardData.fromJson(json['data']),
    );
  }
}

class RingkasanDashboardData {
  final Ringkasan ringkasan;
  final List<MateriHariIni> materiHariIni;
  final List<TugasTerbaru> tugasTerbaru;
  final List<dynamic> kelasHariIni;

  RingkasanDashboardData({
    required this.ringkasan,
    required this.materiHariIni,
    required this.tugasTerbaru,
    required this.kelasHariIni,
  });

  factory RingkasanDashboardData.fromJson(Map<String, dynamic> json) {
    return RingkasanDashboardData(
      ringkasan: Ringkasan.fromJson(json['ringkasan']),
      materiHariIni: List<MateriHariIni>.from(
        json['materi_hari_ini'].map((x) => MateriHariIni.fromJson(x)),
      ),
      tugasTerbaru: List<TugasTerbaru>.from(
        json['tugas_terbaru'].map((x) => TugasTerbaru.fromJson(x)),
      ),
      kelasHariIni: List<dynamic>.from(json['kelas_hari_ini']),
    );
  }
}

class Ringkasan {
  final int tugasBelumDikerjakan;
  final int tugasTerlambat;
  final int absensiTidakHadir;
  final int materiHariIni;

  Ringkasan({
    required this.tugasBelumDikerjakan,
    required this.tugasTerlambat,
    required this.absensiTidakHadir,
    required this.materiHariIni,
  });

  factory Ringkasan.fromJson(Map<String, dynamic> json) {
    return Ringkasan(
      tugasBelumDikerjakan: json['tugas_belum_dikerjakan'],
      tugasTerlambat: json['tugas_terlambat'],
      absensiTidakHadir: json['absensi_tidak_hadir'],
      materiHariIni: json['materi_hari_ini'],
    );
  }
}

class MateriHariIni {
  final String materiId;
  final String namaMateri;
  final String uraian;
  final String lampiran;
  final String namaMapel;
  final DateTime createdAt;

  MateriHariIni({
    required this.materiId,
    required this.namaMateri,
    required this.uraian,
    required this.lampiran,
    required this.namaMapel,
    required this.createdAt,
  });

  factory MateriHariIni.fromJson(Map<String, dynamic> json) {
    return MateriHariIni(
      materiId: json['materi_id'],
      namaMateri: json['nama_materi'],
      uraian: json['uraian'],
      lampiran: json['lampiran'],
      namaMapel: json['nama_mapel'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class TugasTerbaru {
  final String id;
  final String judul;
  final String deskripsi;
  final String mapel;
  final String lampiranGuru;
  final DateTime tenggatKumpul;
  final DateTime? dikumpulkanPada;
  final String? fileJawaban;
  final String? uraianJawaban;
  final int? nilai;
  final String status;
  final DateTime dibuatPada;

  TugasTerbaru({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.mapel,
    required this.lampiranGuru,
    required this.tenggatKumpul,
    this.dikumpulkanPada,
    this.fileJawaban,
    this.uraianJawaban,
    this.nilai,
    required this.status,
    required this.dibuatPada,
  });

  factory TugasTerbaru.fromJson(Map<String, dynamic> json) {
    return TugasTerbaru(
      id: json['id'],
      judul: json['judul'],
      deskripsi: json['deskripsi'],
      mapel: json['mapel'],
      lampiranGuru: json['lampiran_guru'],
      tenggatKumpul: DateTime.parse(json['tenggat_kumpul']),
      dikumpulkanPada: json['dikumpulkan_pada'] != null
          ? DateTime.tryParse(json['dikumpulkan_pada'])
          : null,
      fileJawaban: json['file_jawaban'],
      uraianJawaban: json['uraian_jawaban'],
      nilai: json['nilai'],
      status: json['status'],
      dibuatPada: DateTime.parse(json['dibuat_pada']),
    );
  }
}
