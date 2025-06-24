import 'package:sina_mobile/Model/Nilai.dart';
import 'package:sina_mobile/Model/SiswaResponse.dart';
import 'package:sina_mobile/Model/kelas.dart';

class DetailRaporResponse {
  final String message;
  final int status;
  final RaporData data;

  DetailRaporResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory DetailRaporResponse.fromJson(Map<String, dynamic> json) {
    return DetailRaporResponse(
      message: json['message'],
      status: json['status'],
      data: RaporData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
      'data': data.toJson(),
    };
  }
}

class RaporData {
  final String? pdfUrl;
  final String? downloadUrl;

  RaporData({
    required this.pdfUrl,
    required this.downloadUrl,
  });

  factory RaporData.fromJson(Map<String, dynamic> json) {
    return RaporData(
      pdfUrl: json['pdf_url'],
      downloadUrl: json['download_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pdf_url': pdfUrl,
      'download_url': downloadUrl,
    };
  }
}

