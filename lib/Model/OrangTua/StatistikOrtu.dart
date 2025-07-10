class StatistikOrtu {
  final String siswa;
  final List<String> kelasTersedia;
  final List<StatistikMapel> data;

  StatistikOrtu({
    required this.siswa,
    required this.kelasTersedia,
    required this.data,
  });

  factory StatistikOrtu.fromJson(Map<String, dynamic> json) {
    return StatistikOrtu(
      siswa: json['siswa'],
      kelasTersedia: List<String>.from(json['kelas_tersedia']),
      data: List<StatistikMapel>.from(
        json['data'].map((x) => StatistikMapel.fromJson(x)),
      ),
    );
  }
}

class StatistikMapel {
  final String kelas;
  final String mapel;
  final int? nilai;

  StatistikMapel({required this.kelas, required this.mapel, this.nilai});

  factory StatistikMapel.fromJson(Map<String, dynamic> json) {
    return StatistikMapel(
      kelas: json['kelas'],
      mapel: json['mapel'],
      nilai: json['nilai'],
    );
  }
}
