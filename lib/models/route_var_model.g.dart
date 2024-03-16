// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_var_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteVarModel _$RouteVarModelFromJson(Map<String, dynamic> json) =>
    RouteVarModel(
      id: json['id'] as String,
      routeVarId: json['routeVarId'] as int,
      routeVarName: json['routeVarName'] as String,
      routeVarShortName: json['routeVarShortName'] as String,
      startStop: json['startStop'] as String,
      endStop: json['endStop'] as String,
      outBound: json['outBound'] as bool,
      runningTime: json['runningTime'] as num,
      distance: json['distance'] as num,
    );

Map<String, dynamic> _$RouteVarModelToJson(RouteVarModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'routeVarId': instance.routeVarId,
      'routeVarName': instance.routeVarName,
      'routeVarShortName': instance.routeVarShortName,
      'startStop': instance.startStop,
      'endStop': instance.endStop,
      'outBound': instance.outBound,
      'runningTime': instance.runningTime,
      'distance': instance.distance,
    };
