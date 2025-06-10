class JadwalGuru {
  final bool success;
  final List<JadwalItem> data;

  JadwalGuru({
    required this.success,
    required this.data,
  });

  factory JadwalGuru.fromJson(Map<String, dynamic> json) {
    return JadwalGuru(
      success: json['success'],
      data: List<JadwalItem>.from(
        json['data'].map((item) => JadwalItem.fromJson(item)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class JadwalItem {
  final int jamKe;
  final String start;
  final String finish;
  final String hari;
  final String namaMapel;
  final String namaKelas;

  JadwalItem({
    required this.jamKe,
    required this.start,
    required this.finish,
    required this.hari,
    required this.namaMapel,
    required this.namaKelas,
  });

  factory JadwalItem.fromJson(Map<String, dynamic> json) {
    return JadwalItem(
      jamKe: json['jam_ke'],
      start: json['start'],
      finish: json['finish'],
      hari: json['hari'],
      namaMapel: json['nama_mapel'],
      namaKelas: json['nama_kelas'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jam_ke': jamKe,
      'start': start,
      'finish': finish,
      'hari': hari,
      'nama_mapel': namaMapel,
      'nama_kelas': namaKelas,
    };
  }
}
