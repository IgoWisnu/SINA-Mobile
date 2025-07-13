// lib/Model/OrangTua/RiwayatAbsensi.dart
class RiwayatAbsensi {
  final String tanggal;
  final String status;
  final String? suratUrl;

  RiwayatAbsensi({required this.tanggal, required this.status, this.suratUrl});

  factory RiwayatAbsensi.fromJson(Map<String, dynamic> json) {
    return RiwayatAbsensi(
      tanggal: json['tanggal'],
      status: json['status'],
      suratUrl: json['surat']?.toString(),
    );
  }
}
