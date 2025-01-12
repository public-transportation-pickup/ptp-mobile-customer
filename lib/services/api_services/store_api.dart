import 'dart:convert';
import 'package:capstone_ptp/models/store_model.dart';
import 'package:http/http.dart' as http;

import '../../models/menu_model.dart';
import '../local_variables.dart';
import 'api_services.dart';

class StoreApi extends ApiService {
  // GET STORES
  static Future<List<StoreModel>> getStores() async {
    final Uri storeUri = Uri.parse('${ApiService.baseUrl}/stores');
    final response = await http.get(
      storeUri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${LocalVariables.jwtToken}',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => StoreModel.fromJson(json)).toList();
    } else {
      ApiService.checkLog.e('Failed to load stores ${response.statusCode}');
      throw Exception('Failed to load stores ${response.statusCode}');
    }
  }

  //GET STORE BY STORE ID
  static Future<StoreModel> getStoreById(String storeId) async {
    final Uri storeUrl = Uri.parse('${ApiService.baseUrl}/stores/$storeId');
    try {
      final response = await http.get(
        storeUrl,
        headers: {'Content-Type': 'application/json'},
      );
      // print("Store ID: ${storeId}");

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        // ApiService.checkLog.t(jsonResponse);
        return StoreModel.fromJson(jsonResponse);
      } else {
        ApiService.checkLog.e('Failed to load store: ${response.statusCode}');
        throw Exception('Failed to load store: ${response.statusCode}');
      }
    } catch (e) {
      ApiService.checkLog.e('Error while fetching store: $e');
      throw Exception('Error while fetching store: $e');
    }
  }

  //GET PRODUCTS IN MENU OF STORE AT SPECIFIC TIME
  static Future<Menu> getProductsInMenuOfStore(
      String storeId, String arrivalTime, String dateApply) async {
    final Uri storeUrl = Uri.parse(
        '${ApiService.baseUrl}/stores/$storeId/menus?arrivalTime=$arrivalTime&dateApply=$dateApply');
    try {
      final response = await http.get(
        storeUrl,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        //ApiService.checkLog.t(jsonResponse);
        return Menu.fromJson(jsonResponse);
      } else if (response.statusCode == 404) {
        // Return an empty list when resource is not found
        throw Exception('Menu not found');
      } else {
        ApiService.checkLog
            .e('Failed to load products in menu: ${response.statusCode}');
        throw Exception(
            'Failed to load products in menu: ${response.statusCode}');
      }
    } catch (e) {
      ApiService.checkLog.e('Error while fetching products in menu: $e');
      throw Exception('Error while fetching products in menu: $e');
    }
  }

  // GET STORES BY ROUTE VAR ID
  static Future<List<StoreModel>> getStoresByRouteVarId(
      String routeVarId) async {
    final String baseUrl = '${ApiService.baseUrl}/routevars/$routeVarId/stores';
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      //ApiService.checkLog.t(jsonResponse);
      return jsonResponse.map((json) => StoreModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load stores: ${response.statusCode}');
    }
  }
}
