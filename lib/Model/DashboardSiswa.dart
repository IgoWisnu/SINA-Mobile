class DashboardResponse {
  final int status;
  final DashboardStatus data;

  DashboardResponse({
    required this.status,
    required this.data,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> json) {
    return DashboardResponse(
      status: json['status'],
      data: DashboardStatus.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.toJson(),
    };
  }
}

class DashboardStatus {
  final int tugasBelumDikerjakan;
  final int tugasTerlambat;
  final int absensiTidakHadir;

  DashboardStatus({
    required this.tugasBelumDikerjakan,
    required this.tugasTerlambat,
    required this.absensiTidakHadir,
  });

  factory DashboardStatus.fromJson(Map<String, dynamic> json) {
    return DashboardStatus(
      tugasBelumDikerjakan: json['tugas_belum_dikerjakan'],
      tugasTerlambat: json['tugas_terlambat'],
      absensiTidakHadir: json['absensi_tidak_hadir'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tugas_belum_dikerjakan': tugasBelumDikerjakan,
      'tugas_terlambat': tugasTerlambat,
      'absensi_tidak_hadir': absensiTidakHadir,
    };
  }
}


