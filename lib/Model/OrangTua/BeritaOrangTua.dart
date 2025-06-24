import 'package:sina_mobile/Model/Berita.dart';

class BeritaOrangTuaResponse {
  final String message;
  final int status; // ✅ hkarena dari JSON: "status": 200
  final List<Berita> data;

  BeritaOrangTuaResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory BeritaOrangTuaResponse.fromJson(Map<String, dynamic> json) {
    return BeritaOrangTuaResponse(
      message: json['message'],
      status: json['status'],
      data:
          (json['data'] as List).map((item) => Berita.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class Berita {
  final String beritaId;
  final String judul;
  final String foto;
  final String isi;
  final String tipe;
  final DateTime createdAt;
  final String? namaGuru;
  final String? namaAdmin;

  Berita({
    required this.beritaId,
    required this.judul,
    required this.foto,
    required this.isi,
    required this.tipe,
    required this.createdAt,
    this.namaGuru,
    this.namaAdmin,
  });

  factory Berita.fromJson(Map<String, dynamic> json) {
    return Berita(
      beritaId: json['berita_id'] ?? '',
      judul: json['judul'],
      foto: json['foto'],
      isi: json['isi'],
      tipe: json['tipe'],
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      namaGuru: json['nama_guru'],
      namaAdmin: json['nama_admin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'berita_id': beritaId,
      'judul': judul,
      'foto': foto,
      'isi': isi,
      'tipe': tipe,
      'created_at': createdAt.toIso8601String(),
      'nama_guru': namaGuru,
      'nama_admin': namaAdmin,
    };
  }
}
