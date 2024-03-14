import 'package:json_annotation/json_annotation.dart';

part 'schedule_model.g.dart';

@JsonSerializable()
class ScheduleModel {
  final int index;
  @JsonKey(name: 'distanceFromStart')
  final int distanceFromStart;
  @JsonKey(name: 'distanceToNext')
  final int distanceToNext;
  @JsonKey(name: 'durationFromStart')
  final double durationFromStart;
  @JsonKey(name: 'durationToNext')
  final double durationToNext;
  @JsonKey(name: 'stationName')
  final String stationName;
  @JsonKey(name: 'arrivalTime')
  final String arrivalTime;
  final String? storeId;
  @JsonKey(name: 'stationId')
  final String stationId;

  ScheduleModel({
    required this.index,
    required this.distanceFromStart,
    required this.distanceToNext,
    required this.durationFromStart,
    required this.durationToNext,
    required this.stationName,
    required this.arrivalTime,
    required this.storeId,
    required this.stationId,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleModelToJson(this);
}
