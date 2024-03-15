import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../models/product_model.dart';
import 'api_services.dart';

class ProductApi extends ApiService {
  static var checkLog = Logger(printer: PrettyPrinter());

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
        checkLog.e('Failed to load store: ${response.statusCode}');
        throw Exception('Failed to load store: ${response.statusCode}');
      }
    } catch (e) {
      checkLog.e('Error while fetching store: $e');
      throw Exception('Error while fetching store: $e');
    }
  }
}
