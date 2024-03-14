// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleModel _$ScheduleModelFromJson(Map<String, dynamic> json) =>
    ScheduleModel(
      index: json['index'] as int,
      distanceFromStart: json['distanceFromStart'] as int,
      distanceToNext: json['distanceToNext'] as int,
      durationFromStart: (json['durationFromStart'] as num).toDouble(),
      durationToNext: (json['durationToNext'] as num).toDouble(),
      stationName: json['stationName'] as String,
      arrivalTime: json['arrivalTime'] as String,
      storeId: json['storeId'] as String?,
      stationId: json['stationId'] as String,
    );

Map<String, dynamic> _$ScheduleModelToJson(ScheduleModel instance) =>
    <String, dynamic>{
      'index': instance.index,
      'distanceFromStart': instance.distanceFromStart,
      'distanceToNext': instance.distanceToNext,
      'durationFromStart': instance.durationFromStart,
      'durationToNext': instance.durationToNext,
      'stationName': instance.stationName,
      'arrivalTime': instance.arrivalTime,
      'storeId': instance.storeId ?? '',
      'stationId': instance.stationId,
    };
