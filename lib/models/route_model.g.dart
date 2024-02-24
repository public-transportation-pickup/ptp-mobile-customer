// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteModel _$RouteModelFromJson(Map<String, dynamic> json) => RouteModel(
      id: json['id'] as String,
      routeNo: json['routeNo'] as String,
      name: json['name'] as String,
      status: json['status'] as String,
      distance: json['distance'] as int,
      timeOfTrip: json['timeOfTrip'] as String,
      headWay: json['headWay'] as String,
      operationTime: json['operationTime'] as String,
      numOfSeats: json['numOfSeats'] as String,
      inboundName: json['inboundName'] as String,
      outBoundName: json['outBoundName'] as String,
      totalTrip: json['totalTrip'] as String,
      orgs: json['orgs'] as String,
      tickets: json['tickets'] as String,
    );

Map<String, dynamic> _$RouteModelToJson(RouteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'routeNo': instance.routeNo,
      'name': instance.name,
      'status': instance.status,
      'distance': instance.distance,
      'timeOfTrip': instance.timeOfTrip,
      'headWay': instance.headWay,
      'operationTime': instance.operationTime,
      'numOfSeats': instance.numOfSeats,
      'inboundName': instance.inboundName,
      'outBoundName': instance.outBoundName,
      'totalTrip': instance.totalTrip,
      'orgs': instance.orgs,
      'tickets': instance.tickets,
    };
