import 'package:json_annotation/json_annotation.dart';

part 'route_model.g.dart';

@JsonSerializable()
class RouteModel {
  final String id;
  final String routeNo;
  final String name;
  final String status;
  final int distance;
  final String timeOfTrip;
  final String headWay;
  final String operationTime;
  final String numOfSeats;
  final String inboundName;
  final String outBoundName;
  final String totalTrip;
  final String orgs;
  final String tickets;

  RouteModel({
    required this.id,
    required this.routeNo,
    required this.name,
    required this.status,
    required this.distance,
    required this.timeOfTrip,
    required this.headWay,
    required this.operationTime,
    required this.numOfSeats,
    required this.inboundName,
    required this.outBoundName,
    required this.totalTrip,
    required this.orgs,
    required this.tickets,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) =>
      _$RouteModelFromJson(json);

  Map<String, dynamic> toJson() => _$RouteModelToJson(this);
}
