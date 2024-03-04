import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../models/order_model.dart';
import '../local_variables.dart';
import 'api_services.dart';

class OrderApi extends ApiService {
  static var checkLog = Logger(printer: PrettyPrinter());

  static Future<List<OrderModel>> getOrdersOfUser(
      {int pageNumber = 1, int pageSize = 100}) async {
    final Uri ordersUrl = Uri.parse(
        '${ApiService.baseUrl}/users/orders?pageNumber=$pageNumber&pageSize=$pageSize');

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
