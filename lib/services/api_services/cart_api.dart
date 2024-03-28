import 'dart:convert';
import 'package:capstone_ptp/models/update_cart_model.dart';
import 'package:capstone_ptp/services/local_variables.dart';
import 'package:capstone_ptp/models/cart_model.dart';
import 'package:http/http.dart' as http;

import '../../models/create_cart_model.dart';
import 'api_services.dart';

class CartApi extends ApiService {
  // GET CART OF USER
  static Future<Cart?> fetchCart() async {
    final Uri cartUrl = Uri.parse('${ApiService.baseUrl}/carts');

    final response = await http.get(
      cartUrl,
      headers: {
        'Authorization': 'Bearer ${LocalVariables.jwtToken}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      ApiService.checkLog.t(response.body);
      return Cart.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 204) {
      // If status code is 204, return null to indicate an empty cart
      return null;
    } else {
      throw Exception('Failed to load cart');
    }
  }

  // CREATE CART
  static Future<bool> createCart(CreateCartModel cartModel) async {
    final Uri cartUrl = Uri.parse('${ApiService.baseUrl}/carts');
    final response = await http.post(
      cartUrl,
      headers: {
        'Authorization': 'Bearer ${LocalVariables.jwtToken}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(CreateCartRequest(model: cartModel).toJson()),
    );
    ApiService.checkLog
        .t(jsonEncode(CreateCartRequest(model: cartModel).toJson()));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to create cart');
    }
  }

  // UPDATE CART
  static Future<bool> updateCart(UpdateCartModel cartModel) async {
    final Uri cartUrl = Uri.parse('${ApiService.baseUrl}/carts');
    final response = await http.put(
      cartUrl,
      headers: {
        'Authorization': 'Bearer ${LocalVariables.jwtToken}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(UpdateCartRequest(model: cartModel).toJson()),
    );
    ApiService.checkLog
        .t(jsonEncode(UpdateCartRequest(model: cartModel).toJson()));
    if (response.statusCode == 204) {
      return true;
    } else {
      throw Exception('Failed to update cart');
    }
  }

  // DELETE CART
  static Future<bool> deleteCart() async {
    final Uri cartUrl = Uri.parse('${ApiService.baseUrl}/carts');
    final response = await http.delete(
      cartUrl,
      headers: {
        'Authorization': 'Bearer ${LocalVariables.jwtToken}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to delete cart');
    }
  }
}
