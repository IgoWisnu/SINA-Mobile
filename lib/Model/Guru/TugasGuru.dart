class TugasGuru {
  final bool success;
  final List<TugasItem> data;

  TugasGuru({
    required this.success,
    required this.data,
  });

  factory TugasGuru.fromJson(Map<String, dynamic> json) {
    return TugasGuru(
      success: json['success'],
      data: List<TugasItem>.from(
        json['data'].map((item) => TugasItem.fromJson(item)),
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

class TugasItem {
  final String tugasId;
  final String judul;
  final String deskripsi;
  final String lampiran;
  final DateTime tenggatKumpul;
  final DateTime createdAt;
  final int jumlahSiswa;
  final int jumlahDikumpulkan;
  final int jumlahTerlambat;

  TugasItem({
    required this.tugasId,
    required this.judul,
    required this.deskripsi,
    required this.lampiran,
    required this.tenggatKumpul,
    required this.createdAt,
    required this.jumlahSiswa,
    required this.jumlahDikumpulkan,
    required this.jumlahTerlambat,
  });

  factory TugasItem.fromJson(Map<String, dynamic> json) {
    return TugasItem(
      tugasId: json['tugas_id'],
      judul: json['judul'],
      deskripsi: json['deskripsi'],
      lampiran: json['lampiran'],
      tenggatKumpul: DateTime.parse(json['tenggat_kumpul']),
      createdAt: DateTime.parse(json['created_at']),
      jumlahSiswa: json['jumlah_siswa'],
      jumlahDikumpulkan: int.parse(json['jumlah_dikumpulkan']),
      jumlahTerlambat: int.parse(json['jumlah_terlambat']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tugas_id': tugasId,
      'judul': judul,
      'deskripsi': deskripsi,
      'lampiran': lampiran,
      'tenggat_kumpul': tenggatKumpul.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'jumlah_siswa': jumlahSiswa,
      'jumlah_dikumpulkan': jumlahDikumpulkan.toString(),
      'jumlah_terlambat': jumlahTerlambat.toString(),
    };
  }
}
