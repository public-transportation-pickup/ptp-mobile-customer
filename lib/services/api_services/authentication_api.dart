import 'dart:convert';
import 'package:capstone_ptp/services/local_variables.dart';
import 'package:http/http.dart' as http;

import 'api_services.dart';

class AuthenticationApi extends ApiService {
  // Authentication
  static Future<Map<String, dynamic>> login(String token) async {
    final Uri loginUrl = Uri.parse('${ApiService.baseUrl}/auth');
    final Map<String, String> body = {'token': token, 'role': 'customer'};

    final response = await http.post(
      loginUrl,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      LocalVariables.jwtToken = responseBody['token'];
      LocalVariables.userGUID = responseBody['user']['id'];
      ApiService.checkLog.i('System JWT: ${LocalVariables.jwtToken}');
      ApiService.checkLog.t(responseBody);
      return responseBody;
    } else {
      ApiService.checkLog.e('Failed to login: ${response.statusCode}');
      throw Exception('Failed to login: ${response.statusCode}');
    }
  }
}
