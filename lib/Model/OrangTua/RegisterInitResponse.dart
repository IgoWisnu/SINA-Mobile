class RegisterInitResponse {
  final bool success;
  final String message;
  final RegisterData? data;

  RegisterInitResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory RegisterInitResponse.fromJson(Map<String, dynamic> json) {
    return RegisterInitResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? RegisterData.fromJson(json['data']) : null,
    );
  }
}

class RegisterData {
  final String nis;
  final String namaSiswa;
  final String statusOrtu;
  final String emailOrtu;
  final String namaOrtu;

  RegisterData({
    required this.nis,
    required this.namaSiswa,
    required this.statusOrtu,
    required this.emailOrtu,
    required this.namaOrtu,
  });

  factory RegisterData.fromJson(Map<String, dynamic> json) {
    return RegisterData(
      nis: json['nis'],
      namaSiswa: json['nama_siswa'],
      statusOrtu: json['status_ortu'],
      emailOrtu: json['email_ortu'],
      namaOrtu: json['nama_ortu'],
    );
  }
}

class RegisterVerifyResponse {
  final bool success;
  final String message;
  final VerifyData? data;

  RegisterVerifyResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory RegisterVerifyResponse.fromJson(Map<String, dynamic> json) {
    return RegisterVerifyResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? VerifyData.fromJson(json['data']) : null,
    );
  }
}

class VerifyData {
  final String userId;
  final String email;
  final String statusOrtu;
  final String imei;

  VerifyData({
    required this.userId,
    required this.email,
    required this.statusOrtu,
    required this.imei,
  });

  factory VerifyData.fromJson(Map<String, dynamic> json) {
    return VerifyData(
      userId: json['user_id'].toString(),
      email: json['email'].toString(),
      statusOrtu: json['status_ortu'].toString(),
      imei: json['imei'].toString(),
    );
  }
}
