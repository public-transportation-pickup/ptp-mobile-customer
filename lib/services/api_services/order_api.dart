import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/order_model.dart';
import '../../models/order_create_model.dart';
import '../local_variables.dart';
import 'api_services.dart';

class OrderApi extends ApiService {
  // GET ORDERS OF USER
  static Future<List<OrderModel>> getOrdersOfUser(
      {int pageNumber = -1, int pageSize = 100}) async {
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
      //ApiService.checkLog.t(jsonResponse);
      return jsonResponse.map((json) => OrderModel.fromJson(json)).toList();
    } else {
      ApiService.checkLog.e('Failed to load orders: ${response.statusCode}');
      throw Exception('Failed to load orders: ${response.statusCode}');
    }
  }

  static Future<OrderModel> getOrderDetails(String orderUuid) async {
    final Uri orderDetailsUrl =
        Uri.parse('${ApiService.baseUrl}/order/$orderUuid');

    final response = await http.get(
      orderDetailsUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${LocalVariables.jwtToken}',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return OrderModel.fromJson(jsonResponse);
    } else {
      ApiService.checkLog
          .e('Failed to load order details: ${response.statusCode}');
      throw Exception('Failed to load order details: ${response.statusCode}');
    }
  }

  static Future<bool> createOrder(OrderCreateModel order) async {
    final Uri orderUrl = Uri.parse('${ApiService.baseUrl}/order');

    final response = await http.post(
      orderUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${LocalVariables.jwtToken}',
      },
      body: jsonEncode(order.toJson()),
    );

    ApiService.checkLog.t(jsonEncode(order.toJson()));

    if (response.statusCode == 201) {
      return true; // Success
    } else {
      ApiService.checkLog.e('Failed to create order: ${response.statusCode}');
      return false; // Failure
    }
  }

  // CANCEL ORDER
  static Future<bool> cancelOrder(String orderId) async {
    final Uri cancelOrderUrl =
        Uri.parse('${ApiService.baseUrl}/order/$orderId');

    final Map<String, dynamic> requestBody = {
      "id": orderId,
      "canceledReason": "Bố m thích hủy đấy, rồi sao? làm j nhau",
      "status": "Canceled"
    };

    final response = await http.put(
      cancelOrderUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${LocalVariables.jwtToken}',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 204) {
      return true;
    } else {
      ApiService.checkLog.e('Failed to cancel order: ${response.statusCode}');
      return false;
    }
  }
}
