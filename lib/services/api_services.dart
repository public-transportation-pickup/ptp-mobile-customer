import 'dart:convert';
import 'package:capstone_ptp/services/local_variables.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../models/route_model.dart';
import '../models/order_model.dart';

class ApiService {
  // CHECK LOG
  static var checkLog = Logger(printer: PrettyPrinter());

  // DOMAIN CALL API
  //static const String baseUrl = "http://localhost:5066/api";
  //static const String baseUrl = "http://183.80.125.249:5000/api";
  static const String baseUrl = 'http://ptp-srv.ddns.net:5000/api';

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
      // Save token
      LocalVariables.jwtToken = responseBody['token'];
      checkLog.i('System JWT: ${LocalVariables.jwtToken}');
      checkLog.t(responseBody);
      return responseBody;
    } else {
      checkLog.e('Failed to login: ${response.statusCode}');
      throw Exception('Failed to login: ${response.statusCode}');
    }
  }

  static Future<List<RouteModel>> getRoutes() async {
    final Uri routesUrl = Uri.parse('$baseUrl/routes');

    final response = await http.get(
      routesUrl,
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer ${LocalVariables.jwtToken}',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => RouteModel.fromJson(json)).toList();
    } else {
      checkLog.e('Failed to load routes: ${response.statusCode}');
      throw Exception('Failed to load routes: ${response.statusCode}');
    }
  }

  static Future<List<OrderModel>> getOrdersOfUser(
      {int pageNumber = 1, int pageSize = 100}) async {
    final Uri ordersUrl = Uri.parse(
        '$baseUrl/users/orders?pageNumber=$pageNumber&pageSize=$pageSize');

    final response = await http.get(
      ordersUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${LocalVariables.jwtToken}',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      checkLog.t(jsonResponse);
      return jsonResponse.map((json) => OrderModel.fromJson(json)).toList();
    } else {
      checkLog.e('Failed to load orders: ${response.statusCode}');
      throw Exception('Failed to load orders: ${response.statusCode}');
    }
  }
}
