import 'package:http/http.dart' as http;

class ApiServiceGuru {
  static const String baseUrl = 'http://sina.pnb.ac.id:3007/api';

  final http.Client client;

  ApiServiceGuru({http.Client? client}) : client = client ?? http.Client();

  Uri buildUrl(String endpoint) => Uri.parse('$baseUrl/$endpoint');
}
