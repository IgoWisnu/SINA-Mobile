class PengumpulanTugasResponse {
  final bool success;
  final PengumpulanTugasData data;

  PengumpulanTugasResponse({
    required this.success,
    required this.data,
  });

  factory PengumpulanTugasResponse.fromJson(Map<String, dynamic> json) {
    return PengumpulanTugasResponse(
      success: json['success'],
      data: PengumpulanTugasData.fromJson(json['data']),
    );
  }
}

class PengumpulanTugasData {
  final List<SudahMengumpulkan> sudahMengumpulkan;
  final List<BelumMengumpulkan> belumMengumpulkan;
  final int totalSudahMengumpulkan;
  final int totalBelumMengumpulkan;

  PengumpulanTugasData({
    required this.sudahMengumpulkan,
    required this.belumMengumpulkan,
    required this.totalSudahMengumpulkan,
    required this.totalBelumMengumpulkan,
  });

  factory PengumpulanTugasData.fromJson(Map<String, dynamic> json) {
    return PengumpulanTugasData(
      sudahMengumpulkan: (json['sudah_mengumpulkan'] as List)
          .map((e) => SudahMengumpulkan.fromJson(e))
          .toList(),
      belumMengumpulkan: (json['belum_mengumpulkan'] as List)
          .map((e) => BelumMengumpulkan.fromJson(e))
          .toList(),
      totalSudahMengumpulkan: json['total_sudah_mengumpulkan'],
      totalBelumMengumpulkan: json['total_belum_mengumpulkan'],
    );
  }
}

class SudahMengumpulkan {
  final String nis;
  final String namaSiswa;
  final String krsId;
  final DateTime tanggalPengumpulan;
  final String uraian;
  final String fileJawaban;
  final String? nilai;
  final String statusPengumpulan;
  final DateTime tenggatKumpul;
  final String judulTugas;

  SudahMengumpulkan({
    required this.nis,
    required this.namaSiswa,
    required this.krsId,
    required this.tanggalPengumpulan,
    required this.uraian,
    required this.fileJawaban,
    this.nilai,
    required this.statusPengumpulan,
    required this.tenggatKumpul,
    required this.judulTugas,
  });

  factory SudahMengumpulkan.fromJson(Map<String, dynamic> json) {
    return SudahMengumpulkan(
      nis: json['nis'],
      namaSiswa: json['nama_siswa'],
      krsId: json['krs_id'],
      tanggalPengumpulan: DateTime.parse(json['tanggal_pengumpulan']),
      uraian: json['uraian'],
      fileJawaban: json['file_jawaban'],
      nilai: json['nilai']?.toString(),
      statusPengumpulan: json['status_pengumpulan'],
      tenggatKumpul: DateTime.parse(json['tenggat_kumpul']),
      judulTugas: json['judul_tugas'],
    );
  }
}

class BelumMengumpulkan {
  final String nis;
  final String namaSiswa;

  BelumMengumpulkan({
    required this.nis,
    required this.namaSiswa,
  });

  factory BelumMengumpulkan.fromJson(Map<String, dynamic> json) {
    return BelumMengumpulkan(
      nis: json['nis'],
      namaSiswa: json['nama_siswa'],
    );
  }
}
