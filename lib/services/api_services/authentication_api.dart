import 'dart:convert';
import 'package:capstone_ptp/services/local_variables.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'api_services.dart';

class AuthenticationApi extends ApiService {
  static var checkLog = Logger(printer: PrettyPrinter());

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
      checkLog.i('System JWT: ${LocalVariables.jwtToken}');
      checkLog.t(responseBody);
      return responseBody;
    } else {
      checkLog.e('Failed to login: ${response.statusCode}');
      throw Exception('Failed to login: ${response.statusCode}');
    }
  }
}
