import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:capstone_ptp/models/station_model.dart';
import 'package:capstone_ptp/services/api_services/api_services.dart';
import 'package:logger/logger.dart';

import '../../models/route_model.dart';

class StationApi extends ApiService {
  static var log = Logger(printer: PrettyPrinter());

  // GET ALL STATIONS
  static Future<List<StationModel>> getStations() async {
    final Uri stationUri = Uri.parse('${ApiService.baseUrl}/stations');
    final response = await http.get(
      stationUri,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => StationModel.fromJson(json)).toList();
    } else {
      log.e('Failed to load stores ${response.statusCode}');
      throw Exception('Failed to load stores ${response.statusCode}');
    }
  }

  // GET ROUTES BY STATION NAME
  static Future<List<RouteModel>> getRoutesByStationName(
      String stationName) async {
    final Uri routesUri = Uri.parse(
        '${ApiService.baseUrl}/stations/routes?stationName=$stationName&pageNumber=-1&pageSize=100');
    final response = await http.get(
      routesUri,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => RouteModel.fromJson(json)).toList();
    } else {
      log.e('Failed to load routes ${response.statusCode}');
      throw Exception('Failed to load routes ${response.statusCode}');
    }
  }
}
