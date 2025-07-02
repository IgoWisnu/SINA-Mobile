class DashboardResponse {
  final String message;
  final DashboardStatus data;

  DashboardResponse({required this.message, required this.data});

  factory DashboardResponse.fromJson(Map<String, dynamic> json) {
    return DashboardResponse(
      message: json['message'] ?? '',
      data: DashboardStatus.fromJson(json['data']),
    );
  }
}

class DashboardStatus {
  final int tugasBelumDikerjakan;
  final int tugasTerlambat;
  final int absensiTidakHadir;
  final int materiHariIni;
  final NotifikasiAnak notifikasiAnak;

  DashboardStatus({
    required this.tugasBelumDikerjakan,
    required this.tugasTerlambat,
    required this.absensiTidakHadir,
    required this.materiHariIni,
    required this.notifikasiAnak,
  });

  factory DashboardStatus.fromJson(Map<String, dynamic> json) {
    final ringkasan = json['ringkasan'] ?? {};
    final notifikasi = json['notifikasi_anak'] ?? {};

    return DashboardStatus(
      tugasBelumDikerjakan: ringkasan['tugas_belum_dikerjakan'] ?? 0,
      tugasTerlambat: ringkasan['tugas_terlambat'] ?? 0,
      absensiTidakHadir: ringkasan['absensi_tidak_hadir'] ?? 0,
      materiHariIni: ringkasan['materi_hari_ini'] ?? 0,
      notifikasiAnak: NotifikasiAnak.fromJson(notifikasi),
    );
  }
}

class NotifikasiAnak {
  final String nama;
  final String statusKehadiran;

  NotifikasiAnak({required this.nama, required this.statusKehadiran});

  factory NotifikasiAnak.fromJson(Map<String, dynamic> json) {
    return NotifikasiAnak(
      nama: json['nama'] ?? '',
      statusKehadiran: json['status_kehadiran'] ?? '',
    );
  }
}
