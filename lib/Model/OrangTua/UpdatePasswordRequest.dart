class UpdatePasswordRequest {
  final String passwordLama;
  final String passwordBaru;
  final String konfirmasiPassword;

  UpdatePasswordRequest({
    required this.passwordLama,
    required this.passwordBaru,
    required this.konfirmasiPassword,
  });

  Map<String, dynamic> toJson() => {
    'password_lama': passwordLama,
    'password_baru': passwordBaru,
    'konfirmasi_password': konfirmasiPassword,
  };
}
