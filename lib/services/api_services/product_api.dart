import 'dart:convert';
import 'package:capstone_ptp/models/product_in_menu_model.dart';
import 'package:http/http.dart' as http;

import '../../models/product_model.dart';
import 'api_services.dart';

class ProductApi extends ApiService {
  //GET PRODUCT BY PRODUCT ID
  static Future<Product> getProductById(String productId) async {
    final Uri productUrl =
        Uri.parse('${ApiService.baseUrl}/products/$productId');
    try {
      final response = await http.get(
        productUrl,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        //checkLog.t(jsonResponse);
        return Product.fromJson(jsonResponse);
      } else {
        ApiService.checkLog.e('Failed to load product: ${response.statusCode}');
        throw Exception('Failed to load product: ${response.statusCode}');
      }
    } catch (e) {
      ApiService.checkLog.e('Error while fetching product: $e');
      throw Exception('Error while fetching product: $e');
    }
  }

  //GET PRODUCT IN MENU BY PRODUCT IN MENU ID
  static Future<ProductInMenu> getProductInMenuById(String productId) async {
    final Uri productUrl =
        Uri.parse('${ApiService.baseUrl}/products-menu/$productId');
    try {
      final response = await http.get(
        productUrl,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        //checkLog.t(jsonResponse);
        return ProductInMenu.fromJson(jsonResponse);
      } else {
        ApiService.checkLog.e('Failed to load product: ${response.statusCode}');
        throw Exception('Failed to load product: ${response.statusCode}');
      }
    } catch (e) {
      ApiService.checkLog.e('Error while fetching product: $e');
      throw Exception('Error while fetching product: $e');
    }
  }
}
