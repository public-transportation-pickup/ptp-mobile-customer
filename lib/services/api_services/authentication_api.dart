import 'dart:convert';
import 'package:capstone_ptp/services/local_variables.dart';
import 'package:http/http.dart' as http;

import '../shared_preferences.dart';
import 'api_services.dart';

class AuthenticationApi extends ApiService {
  // Authentication
  static Future<Map<String, dynamic>> login(String token) async {
    final Uri loginUrl = Uri.parse('${ApiService.baseUrl}/auth');
    final Map<String, String> body = {
      'token': token,
      'role': 'customer',
      'fcmToken': '${LocalVariables.fcmToken}'
    };

    final response = await http.post(
      loginUrl,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    print("FCM Token: ${LocalVariables.fcmToken}");
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      LocalVariables.jwtToken = responseBody['token'];
      LocalVariables.userGUID = responseBody['user']['id'];
      LocalVariables.phoneNumber = responseBody['user']['phoneNumber'];
      LocalVariables.fullName = responseBody['user']['fullName'];
      LocalVariables.dateOfBirth = responseBody['user']['dateOfBirth'];
      ApiService.checkLog.i('System JWT: ${LocalVariables.jwtToken}');
      ApiService.checkLog.t(responseBody);
      await SharedRef.saveToken(LocalVariables.jwtToken!);
      return responseBody;
    } else {
      ApiService.checkLog.e('Failed to login: ${response.statusCode}');
      throw Exception('Failed to login: ${response.statusCode}');
    }
  }

  // REFRESH TOKEN
  static Future<Map<String, dynamic>> refreshToken(String oldToken) async {
    final Uri refreshTokenUrl =
        Uri.parse('${ApiService.baseUrl}/auth/refresh-token');
    final String body = oldToken;

    final response = await http.post(
      refreshTokenUrl,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      // Update your local variables with the new token
      LocalVariables.jwtToken = responseBody['token'];
      ApiService.checkLog.d("Refresh new token: ${LocalVariables.jwtToken}");
      return responseBody;
    } else {
      ApiService.checkLog.e('Failed to refresh token: ${response.statusCode}');
      throw Exception('Failed to refresh token: ${response.statusCode}');
    }
  }
}
