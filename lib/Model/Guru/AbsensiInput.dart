class AbsensiInput {
  final String krsId;
  final String nama;
  String status; // dapat berubah saat user memilih

  AbsensiInput({
    required this.krsId,
    required this.nama,
    this.status = 'H', // default Hadir
  });
}
