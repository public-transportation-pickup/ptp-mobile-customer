import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../models/route_model.dart';
import '../../models/route_var_model.dart';
import '../../models/trip_model.dart';
import 'api_services.dart';

class RouteApi extends ApiService {
  static var checkLog = Logger(printer: PrettyPrinter());

  // GET ALL ROUTES
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

  // GET ROUTE BY ID
  static Future<RouteModel> getRouteDetail(String routeId) async {
    final Uri routeDetailUrl =
        Uri.parse('${ApiService.baseUrl}/routes/$routeId');
    final response = await http.get(
      routeDetailUrl,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return RouteModel.fromJson(jsonResponse);
    } else {
      checkLog.e('Failed to load route details: ${response.statusCode}');
      throw Exception('Failed to load route details: ${response.statusCode}');
    }
  }

  // GET ALL ROUTE VARS (TURN GO & TURN BACK) BY ROUTE ID
  static Future<List<RouteVarModel>> getRouteVarsByRouteId(
      String routeId) async {
    final Uri routeVarsUrl =
        Uri.parse('${ApiService.baseUrl}/routes/$routeId/route-vars');
    final response = await http.get(
      routeVarsUrl,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => RouteVarModel.fromJson(json)).toList();
    } else {
      checkLog.e('Failed to load route vars: ${response.statusCode}');
      throw Exception('Failed to load route vars: ${response.statusCode}');
    }
  }

  // GET ALL TRIPS BY ROUTE ID & ROUTE VAR ID
  static Future<List<TripModel>> getTrips(
      String routeId, String routeVarId) async {
    final Uri tripsUrl = Uri.parse(
        '${ApiService.baseUrl}/routes/$routeId/route-vars/$routeVarId/trips?pageNumber=-1');
    final response = await http.get(
      tripsUrl,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => TripModel.fromJson(json)).toList();
    } else {
      checkLog.e('Failed to load trips: ${response.statusCode}');
      throw Exception('Failed to load trips: ${response.statusCode}');
    }
  }

  //GET TRIP BY TRIP ID WITH SCHEDULE IS TRUE
  static Future<TripModel> getTripById(String tripId) async {
    final Uri tripUrl =
        Uri.parse('${ApiService.baseUrl}/trips/$tripId?isSchedule=true');
    final response = await http.get(
      tripUrl,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return TripModel.fromJson(jsonResponse);
    } else {
      checkLog.e('Failed to load trip: ${response.statusCode}');
      throw Exception('Failed to load trip: ${response.statusCode}');
    }
  }
}
