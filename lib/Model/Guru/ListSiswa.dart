class ListSiswa {
  final bool success;
  final List<AbsensiSiswa> data;

  ListSiswa({
    required this.success,
    required this.data,
  });

  factory ListSiswa.fromJson(Map<String, dynamic> json) {
    return ListSiswa(
      success: json['success'] ?? false,
      data: (json['data'] as List)
          .map((item) => AbsensiSiswa.fromJson(item))
          .toList(),
    );
  }
}

class AbsensiSiswa {
  final String nama;
  final String krsId;

  AbsensiSiswa({
    required this.nama,
    required this.krsId,
  });

  factory AbsensiSiswa.fromJson(Map<String, dynamic> json) {
    return AbsensiSiswa(
      nama: json['nama'] ?? '',
      krsId: json['krs_id'] ?? '',
    );
  }
}