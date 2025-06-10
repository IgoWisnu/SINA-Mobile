class MateriGuru {
  final bool success;
  final List<MateriItem> data;

  MateriGuru({
    required this.success,
    required this.data,
  });

  factory MateriGuru.fromJson(Map<String, dynamic> json) {
    return MateriGuru(
      success: json['success'],
      data: List<MateriItem>.from(
        json['data'].map((item) => MateriItem.fromJson(item)),
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

class MateriItem {
  final String materiId;
  final String namaMateri;
  final String uraian;
  final String lampiran;
  final DateTime createdAt;
  final int jumlahSiswa;

  MateriItem({
    required this.materiId,
    required this.namaMateri,
    required this.uraian,
    required this.lampiran,
    required this.createdAt,
    required this.jumlahSiswa,
  });

  factory MateriItem.fromJson(Map<String, dynamic> json) {
    return MateriItem(
      materiId: json['materi_id'],
      namaMateri: json['nama_materi'],
      uraian: json['uraian'],
      lampiran: json['lampiran'],
      createdAt: DateTime.parse(json['created_at']),
      jumlahSiswa: json['jumlah_siswa'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'materi_id': materiId,
      'nama_materi': namaMateri,
      'uraian': uraian,
      'lampiran': lampiran,
      'created_at': createdAt.toIso8601String(),
      'jumlah_siswa': jumlahSiswa,
    };
  }
}
