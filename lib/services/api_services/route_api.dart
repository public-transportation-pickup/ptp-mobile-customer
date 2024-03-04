import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../models/route_model.dart';
import 'api_services.dart';

class RouteApi extends ApiService {
  static var checkLog = Logger(printer: PrettyPrinter());

  static Future<List<RouteModel>> getRoutes() async {
    final Uri routesUrl = Uri.parse('${ApiService.baseUrl}/routes');
    final response = await http.get(
      routesUrl,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => RouteModel.fromJson(json)).toList();
    } else {
      checkLog.e('Failed to load routes: ${response.statusCode}');
      throw Exception('Failed to load routes: ${response.statusCode}');
    }
  }
}
