import 'package:aquanet_mobile/config/url_config.dart' as urlConfig;
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginService {
  final String baseUrl = urlConfig.url;

  Future<Map<String, dynamic>> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"userName": username, "password": password}),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Login failed: ${jsonDecode(response.body)['message']}');
    }
  }

  Future<Map<String, dynamic>> register(
    String username,
    String email,
    String phoneNumber,
    String password,
  ) async {
    final url = Uri.parse('$baseUrl/auth/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "userName": username,
        "email": email,
        "password": password,
        "phoneNumber": phoneNumber,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      print('${jsonDecode(response.body)['message']}');
      throw Exception('${jsonDecode(response.body)['message']}');
    }
  }
}
