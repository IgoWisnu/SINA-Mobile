class UpdatePasswordRequest {
  final String password_lama;
  final String password_baru;
  final String konfirmasi_password;

  UpdatePasswordRequest({
    required this.password_lama,
    required this.password_baru,
    required this.konfirmasi_password,
  });

  Map<String, dynamic> toJson() => {
    'password_lama': password_lama,
    'password_baru': password_baru,
    'konfirmasi_password': konfirmasi_password,
  };
}
