import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiServiceOrangTua {
  static const String baseUrl = 'http://sina.pnb.ac.id:3006/api';

  final http.Client client;

  ApiServiceOrangTua({http.Client? client}) : client = client ?? http.Client();

  Uri buildUrl(String endpoint) => Uri.parse('$baseUrl/$endpoint');
}
