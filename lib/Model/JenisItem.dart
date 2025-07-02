enum JenisItem { tugas, materi }

class KelasItem {
  final JenisItem jenis;
  final String judul;
  final DateTime uploadDate;
  final dynamic data;

  KelasItem({
    required this.jenis,
    required this.judul,
    required this.uploadDate,
    required this.data,
  });
}
