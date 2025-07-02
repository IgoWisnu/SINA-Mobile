import 'package:http/http.dart' as http;

class ApiServiceAuth {
  static const String baseUrl = 'http://sina.pnb.ac.id:3005/api';

  final http.Client client;

  ApiServiceAuth({http.Client? client}) : client = client ?? http.Client();

  Uri buildUrl(String endpoint) => Uri.parse('$baseUrl/$endpoint');
}
