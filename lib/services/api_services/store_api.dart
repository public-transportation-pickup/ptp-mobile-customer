import 'dart:convert';

import 'package:capstone_ptp/models/store_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'api_services.dart';

class StoreApi extends ApiService {
  static var log = Logger(printer: PrettyPrinter());
  static Future<List<StoreModel>> getStores() async {
    final Uri storeUri = Uri.parse('${ApiService.baseUrl}/stores');
    final response = await http.get(
      storeUri,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => StoreModel.fromJson(json)).toList();
    } else {
      log.e('Failed to load stores ${response.statusCode}');
      throw Exception('Failed to load stores ${response.statusCode}');
    }
  }
}
