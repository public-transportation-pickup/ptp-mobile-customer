import 'dart:convert';
import 'package:capstone_ptp/services/local_variables.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://localhost:5066/api";
  
  static Future<Map<String, dynamic>> login(String token) async {
    final Uri loginUrl = Uri.parse('$baseUrl/auth');

    final Map<String, String> body = {'token': token, 'role': 'customer'};

    final response = await http.post(
      loginUrl,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);

      // Parse and store the token and user information
      LocalVariables.jwtToken = responseBody['token'];

      return responseBody;
    } else {
      throw Exception('Failed to login: ${response.statusCode}');
    }
  }
}
