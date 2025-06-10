class KelasGuru {
  final bool success;
  final List<KelasItem> data;

  KelasGuru({
    required this.success,
    required this.data,
  });

  factory KelasGuru.fromJson(Map<String, dynamic> json) {
    return KelasGuru(
      success: json['success'],
      data: List<KelasItem>.from(
        json['data'].map((item) => KelasItem.fromJson(item)),
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

class KelasItem {
  final String mapelId;
  final String namaMapel;
  final int kkm;
  final int jumlahSiswa;

  KelasItem({
    required this.mapelId,
    required this.namaMapel,
    required this.kkm,
    required this.jumlahSiswa,
  });

  factory KelasItem.fromJson(Map<String, dynamic> json) {
    return KelasItem(
      mapelId: json['mapel_id'],
      namaMapel: json['nama_mapel'],
      kkm: json['kkm'],
      jumlahSiswa: json['jumlah_siswa'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mapel_id': mapelId,
      'nama_mapel': namaMapel,
      'kkm': kkm,
      'jumlah_siswa': jumlahSiswa,
    };
  }
}
