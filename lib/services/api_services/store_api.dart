import 'dart:convert';
import 'package:capstone_ptp/models/store_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'api_services.dart';

class StoreApi extends ApiService {
  static var checkLog = Logger(printer: PrettyPrinter());

  //GET STORE BY STORE ID
  static Future<StoreModel> getStoreById(String storeId) async {
    final Uri storeUrl = Uri.parse('${ApiService.baseUrl}/stores/$storeId');
    try {
      final response = await http.get(
        storeUrl,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        //checkLog.t(jsonResponse);
        return StoreModel.fromJson(jsonResponse);
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
