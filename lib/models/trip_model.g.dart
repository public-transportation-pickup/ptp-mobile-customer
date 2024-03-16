// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripModel _$TripModelFromJson(Map<String, dynamic> json) => TripModel(
      id: json['id'] as String,
      description: json['description'] as String?,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      applyDates: json['applyDates'] as String,
      schedules: (json['schedules'] as List<dynamic>?)
          ?.map((e) => ScheduleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$TripModelToJson(TripModel instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'applyDates': instance.applyDates,
      'schedules': instance.schedules,
      'status': instance.status,
    };
