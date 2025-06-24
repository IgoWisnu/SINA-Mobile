class OrangTuaRespon {
  final String message;
  final String status;
  final Ortu ortu;

  OrangTuaRespon({
    required this.message,
    required this.status,
    required this.ortu,
  });

  factory OrangTuaRespon.fromJson(Map<String, dynamic> json) {
    return OrangTuaRespon(
      message: json['message'] ?? '',
      status: json['status'] ?? '',
      ortu: Ortu.fromJson(json['data']), // ✅ sesuai API
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'status': status, 'data': ortu.toJson()};
  }
}

class Ortu {
  final String nik;
  final String nama_ortu;
  final String imei;
  final String alamat;
  final String status_ortu;
  final String pekerjaan;
  final String tempat_lahir_ortu;
  final DateTime tanggal_lahir_ortu;
  final String no_telepon;

  Ortu({
    required this.nik,
    required this.nama_ortu,
    required this.imei,
    required this.alamat,
    required this.status_ortu,
    required this.pekerjaan,
    required this.tempat_lahir_ortu,
    required this.tanggal_lahir_ortu,
    required this.no_telepon,
  });

  factory Ortu.fromJson(Map<String, dynamic> json) {
    return Ortu(
      nik: json['nik'],
      nama_ortu: json['nama_ortu'],
      imei: json['imei'] ?? '',
      alamat: json['alamat'],
      status_ortu: json['status_ortu'],
      pekerjaan: json['pekerjaan'],
      tempat_lahir_ortu: json['tempat_lahir_ortu'],
      tanggal_lahir_ortu: DateTime.parse(json['tanggal_lahir_ortu']),
      no_telepon: json['no_telepon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nik': nik,
      'nama_ortu': nama_ortu,
      'imei': imei,
      'alamat': alamat,
      'status_ortu': status_ortu,
      'pekerjaan': pekerjaan,
      'tempat_lahir_ortu': tempat_lahir_ortu,
      'tanggal_lahir_ortu': tanggal_lahir_ortu.toIso8601String(),
      'no_telepon': no_telepon,
    };
  }
}
