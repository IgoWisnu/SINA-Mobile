// lib/Model/SuratIzinModel.dart
class SuratIzinModel {
  final String absensiId;
  final String namaSiswa;
  final String nis;
  final DateTime tanggalIzin;
  final String keterangan;
  final String surat;
  final String statusSurat;

  SuratIzinModel({
    required this.absensiId,
    required this.namaSiswa,
    required this.nis,
    required this.tanggalIzin,
    required this.keterangan,
    required this.surat,
    required this.statusSurat,
  });

  factory SuratIzinModel.fromJson(Map<String, dynamic> json) {
    return SuratIzinModel(
      absensiId: json['absensi_id'],
      namaSiswa: json['nama_siswa'],
      nis: json['nis'],
      tanggalIzin: DateTime.parse(json['tanggal_izin']),
      keterangan: json['keterangan'],
      surat: json['surat'],
      statusSurat: json['status_surat'],
    );
  }

  String get formattedDate {
    return "${tanggalIzin.day}/${tanggalIzin.month}/${tanggalIzin.year}";
  }
}
