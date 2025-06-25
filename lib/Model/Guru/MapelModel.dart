class MapelModel {
  final String mapelId;
  final String namaMapel;

  MapelModel({required this.mapelId, required this.namaMapel});

  factory MapelModel.fromJson(Map<String, dynamic> json) {
    return MapelModel(mapelId: json['mapel_id'], namaMapel: json['nama_mapel']);
  }
}
