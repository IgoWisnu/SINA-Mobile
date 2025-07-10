class JadwalResponse {
  final String message;
  final int status;
  final List<Jadwal> jadwalPelajaran;

  JadwalResponse({
    required this.message,
    required this.status,
    required this.jadwalPelajaran,
  });

  factory JadwalResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    final jadwalList = data['jadwal'] as List<dynamic>;

    return JadwalResponse(
      message: json['message'],
      status: json['status'],
      jadwalPelajaran: jadwalList.map((item) => Jadwal.fromJson(item)).toList(),
    );
  }
}

class Jadwal {
  final String jam;
  final String mataPelajaran;
  final String guru;
  final String ruangan;

  Jadwal({
    required this.jam,
    required this.mataPelajaran,
    required this.guru,
    required this.ruangan,
  });

  factory Jadwal.fromJson(Map<String, dynamic> json) {
    return Jadwal(
      jam: json['jam'] ?? '',
      mataPelajaran: json['mata_pelajaran'] ?? '',
      guru: json['guru'] ?? '',
      ruangan: json['ruangan'] ?? '',
    );
  }
}
