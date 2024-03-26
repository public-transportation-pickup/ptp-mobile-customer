import 'dart:convert';
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
  static Future<void> createCart(CreateCartModel cartModel) async {
    final Uri cartUrl = Uri.parse('${ApiService.baseUrl}/carts');
    final response = await http.post(
      cartUrl,
      headers: {
        'Authorization': 'Bearer ${LocalVariables.jwtToken}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(CreateCartRequest(model: cartModel).toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create cart');
    }
  }
}
