import 'dart:convert';
import 'package:capstone_ptp/services/local_variables.dart';
import 'package:http/http.dart' as http;

import 'api_services.dart';

class UserApi extends ApiService {
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

  // Function to update user profile
  static Future<void> updateUserProfile({
    required String userId,
    required String fullName,
    required String phoneNumber,
    required DateTime dateOfBirth,
  }) async {
    final Uri updateUrl = Uri.parse('${ApiService.baseUrl}/users/$userId');
    final Map<String, dynamic> body = {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth.toIso8601String(),
    };

    final response = await http.put(
      updateUrl,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 204) {
      ApiService.checkLog.i('User profile updated successfully');
    } else {
      ApiService.checkLog
          .e('Failed to update user profile: ${response.statusCode}');
      throw Exception('Failed to update user profile: ${response.statusCode}');
    }
  }

  // Function to get user details
  static Future<Map<String, dynamic>> getUserDetails(String userId) async {
    final Uri getUserUrl = Uri.parse('${ApiService.baseUrl}/users/$userId');

    final response = await http.get(
      getUserUrl,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      return responseBody;
    } else {
      ApiService.checkLog
          .e('Failed to get user details: ${response.statusCode}');
      throw Exception('Failed to get user details: ${response.statusCode}');
    }
  }
}
