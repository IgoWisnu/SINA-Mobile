import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://sina.pnb.ac.id:3001/api';

  final http.Client client;

  ApiService({http.Client? client}) : client = client ?? http.Client();

  Uri buildUrl(String endpoint) => Uri.parse('$baseUrl/$endpoint');
}
